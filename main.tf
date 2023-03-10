
/**
* Creates a kibana space with a set of enabled features configured through kibana_features.
* The menu items will become invisible only. To actually disable a feature for a role, we have to apply RBAC through an elasticsearch role in the following resource.
*/
resource "kibana_user_space" "userspace" {
  uid               = var.name
  name              = var.name
  description       = var.name
  disabled_features = setsubtract(local.all_kibana_features, var.kibana_features)

}

/**
* Creates an elasticsearch role with RBAC for kibana features alongside with cluster and index permissions
* The created role is also attached to one or more Kibana spaces.
*/
resource "kibana_role" "role" {
  name = var.name
  elasticsearch {
    cluster = var.cluster_permissions
    dynamic "indices" {
      for_each = var.indices
      content {
        names      = indices.value.names
        privileges = indices.value.privileges
      }
    }
  }
  kibana {
    dynamic "features" {
      for_each = var.kibana_features
      content {
        name        = features.value
        permissions = ["all"]
      }
    }
    spaces = var.kibana_spaces
  }
}

/**
* Elasticsearch role mappings tie the elasticsearch role and an external authentication realm together.
* The mappings accepts one or more input roles
*/
resource "elasticstack_elasticsearch_security_role_mapping" "rm" {
  name    = var.name
  enabled = true
  roles   = var.roles
  rules = jsonencode({
    any = [
      { field = { group = var.auth_group } }
    ]
  })
}

/**
* A component template is an index template that can define index settings and mapping as well as cluster settings
* Instead of defining everything in one template, it is advised to create multiple templates and organize them in an index_template
*/
resource "elasticstack_elasticsearch_component_template" "ct" {
  count = var.index_mapping != null ? 1 : 0
  name  = var.name

  template {
    mappings = var.index_mapping
  }
}

/**
* index templates are a composition of component templates.
* Every team can apply an index mapping for their indices. The template will be applied to all indices defined in `indices`
*/
resource "elasticstack_elasticsearch_index_template" "template" {
  count = var.index_mapping != null ? 1 : 0
  name  = var.name

  index_patterns = [for s in flatten([for i in var.indices : i.names]) : "${s}*"]
  composed_of    = [elasticstack_elasticsearch_component_template.ct[count.index].name, var.base_template]
}
