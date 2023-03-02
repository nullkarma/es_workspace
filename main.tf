
resource "kibana_user_space" "userspace" {
  uid         = var.name
  name        = var.name
  description = var.name
  disabled_features = setsubtract(local.all_kibana_features, var.kibana_features)

}

resource "kibana_role" "role" {
  name     = var.name
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

resource "elasticstack_elasticsearch_security_role_mapping" "rm" {
  name     = var.name
  enabled  = true
  roles    = var.roles
  rules = jsonencode({
    any = [
      { field = { group = var.auth_group } }
    ]
  })
}

resource "elasticstack_elasticsearch_component_template" "ct" {
  count = var.index_mapping != null ? 1 : 0
  name = var.name

  template {
    mappings = var.index_mapping
  }
}

resource "elasticstack_elasticsearch_index_template" "template" {
  count = var.index_mapping != null ? 1 : 0
  name = var.name

  index_patterns = [for s in flatten([for i in var.indices : i.names]) : "${s}*"]
  composed_of    = [elasticstack_elasticsearch_component_template.ct[count.index].name, var.base_template]
}
