
resource "kibana_user_space" "userspace" {
  uid         = var.team_name
  name        = var.team_name
  description = var.team_name
  disabled_features = setsubtract(local.all_kibana_features, var.kibana_features)

}

resource "kibana_role" "role" {
  name     = var.team_name
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

resource "elasticstack_elasticsearch_security_role_mapping" "mapping" {
  name     = var.team_name
  enabled  = true
  roles    = var.roles
  rules = jsonencode({
    any = [
      { field = { group = var.ad_group } }
    ]
  })
}

resource "elasticstack_elasticsearch_component_template" "my_template" {
  name = var.team_name

  template {
    mappings = var.index_mapping
  }
}

resource "elasticstack_elasticsearch_index_template" "my_template" {
  name = var.team_name

  index_patterns = ["${var.team_name}-foobar"]
  composed_of    = [elasticstack_elasticsearch_component_template.my_template.name, var.base_template]
}
