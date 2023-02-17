
resource "kibana_user_space" "userspace" {
  for_each    = var.teams
  uid         = each.key
  name        = each.key
  description = each.key
  disabled_features = setsubtract(local.all_kibana_features, each.value.features)

}

resource "kibana_role" "role" {
  for_each = var.teams
  name     = each.key
  elasticsearch {
    cluster = each.value.cluster_permissions
    dynamic "indices" {
      for_each = each.value.indices
      content {
        names      = indices.value.names
        privileges = indices.value.privileges
      }
    }
  }
  kibana {
    dynamic "features" {
      for_each = each.value.features
      content {
        name        = features.value
        permissions = ["all"]
      }
    }
    spaces = each.value.spaces
  }
}

resource "elasticstack_elasticsearch_security_role_mapping" "mapping" {
  for_each = var.teams
  name     = each.key
  enabled  = true
  roles    = each.value.roles
  rules = jsonencode({
    any = [
      { field = { group = each.value.ad_group } }
    ]
  })
}