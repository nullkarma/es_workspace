/**
 * # Azure Elastic UserSpace and Role Setup
 *  This module configures the kibana Userspaces, elasticsearch role and role mappings
 *
 * [![Elastic-EC-Permissions][welcome_image]][welcome_link]
 * [![Elastic-EC-Permissions][code_image]][code_link]
 * [![Elastic-EC-Permissions][issue_image]][issues_link]
 * [![Elastic-EC-Permissions][doku_image]][doku_link]
 * [![ADR][adr_image]][adr_link]
 * [![Changelog][changelog_image]][changelog_link]
 *
 * [welcome_link]:             https://gowiki.gothaer.de/display/DA
 * [code_link]:                https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace
 * [issues_link]:              https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/issues
 * [doku_link]:                https://www.terraform.io/docs/index.html
 * [changelog_link]:           https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/-/blob/main/CHANGELOG.md
 * [adr_link]:                 https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/-/blob/main/README.md
 * [welcome_image]:            https://img.shields.io/badge/Project-welcome-blue.svg
 * [code_image]:               https://img.shields.io/badge/Terraform_CI-code-green.svg
 * [issue_image]:              https://img.shields.io/badge/Terraform_CI-issues-red.svg
 * [doku_image]:               https://img.shields.io/badge/Terraform_CI-DOKU-yellow.svg
 * [adr_image]:                https://img.shields.io/badge/Terraform_CI-ADR-yellow.svg
 * [changelog_image]:          https://img.shields.io/badge/Terraform_CI-Changelog-purple.svg
 *
 * ## Documentation
 *
 * A module to customize your ...
 *
 *  https://registry.terraform.io/providers/elastic/ec/latest/docs
 *
 * ## Parameters
 *
 */


/**
* Creates a kibana space with a set of enabled features configured through kibana_features.
* The menu items will become invisible only. To actually disable a feature for a role, we have to apply RBAC through an elasticsearch role in the following resource.
* https://www.elastic.co/guide/en/kibana/current/xpack-spaces.html
*/
resource "kibana_user_space" "this" {
  uid               = var.name
  name              = var.name
  description       = var.name
  disabled_features = setsubtract(local.all_kibana_features, var.kibana_features)

}

/**
* Creates an elasticsearch role with RBAC for kibana features alongside with cluster and index permissions
* The created role is also attached to one or more Kibana spaces.
*/
resource "kibana_role" "this" {
  name = var.name
  elasticsearch {
    cluster = var.cluster_permissions
    dynamic "indices" {
      for_each = var.indices
      content {
        names      = [indices.value.name]
        privileges = indices.value.privileges
      }
    }
  }
  kibana {
    dynamic "features" {
      for_each = var.all_privileges ? local.all_kibana_features : var.kibana_features
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
* https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-roles.html
*/
resource "elasticstack_elasticsearch_security_role_mapping" "this" {
  name    = var.name
  enabled = true
  roles   = var.roles
  rules = jsonencode({
    any = [
      { field = { groups = var.auth_group } }
    ]
  })
}


/**
*
* Consumer specific blocks. Only needed for actual kibana users.
*
**/


/**
* Sets up the index lifecycle policy for all defined indices.
* https://www.elastic.co/guide/en/elasticsearch/reference/8.7/index-lifecycle-management.html
*/
resource "elasticstack_elasticsearch_index_lifecycle" "this" {
  count = var.access_only ? 0 : 1
  name  = var.name

  hot {
    min_age = var.index_min_age
    set_priority {
      priority = 10
    }
    rollover {
      max_size = var.index_max_size
      max_docs = 1800000000
    }
  }
  delete {
    min_age = var.delete_index_after
    delete {}
  }
}

/**
* A component template is an index template that can define index settings and mapping as well as cluster settings
* Instead of defining everything in one template, it is advised to create multiple templates and organize them in an index_template
*/
/*
resource "elasticstack_elasticsearch_component_template" "ct-settings" {
  name = "${var.name}-settings"

  template {
    settings = jsonencode(
      {
        number_of_shards = 1
        number_of_replicas = 0
        index = {
          lifecycle = {
            name = var.name
          }
        }
      }
    )
  }
}
*/

/**
* A component template is an index template that can define index settings and mapping as well as cluster settings
* Instead of defining everything in one template, it is advised to create multiple templates and organize them in an index_template
* https://www.elastic.co/guide/en/elasticsearch/reference/8.7/indices-component-template.html
*/
resource "elasticstack_elasticsearch_component_template" "this" {
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
/*
resource "elasticstack_elasticsearch_index_template" "template" {
  count = var.index_mapping != null ? 1 : 0
  name  = var.name

  index_patterns = [for s in flatten([for i in var.indices : i.names]) : "${s}*"]
  composed_of    = [elasticstack_elasticsearch_component_template.ct-settings, elasticstack_elasticsearch_component_template.ct[count.index].name, var.base_template]
}
*/

/**
* index templates are a composition of component templates.
* Every team can apply an index mapping for their indices. The template will be applied to all indices defined in `indices`
* https://www.elastic.co/guide/en/elasticsearch/reference/8.7/indices-put-template.html
* https://www.elastic.co/guide/en/elasticsearch/reference/8.7/index-templates.html
*/
resource "elasticstack_elasticsearch_index_template" "this" {
  for_each       = var.access_only ? toset([]) : local.indices
  name           = each.key
  index_patterns = [startswith(each.key, "*") ? "${each.key}" : "${each.key}*"]
  template {
    // make sure our template uses ILM policy
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.this[0].name
    })
  }

  data_stream {}

  composed_of = [var.base_template]
}

/**
* Creates the data stream for an ilm managed index.
* https://www.elastic.co/guide/en/elasticsearch/reference/8.7/data-streams.html
*/
resource "elasticstack_elasticsearch_data_stream" "this" {
  for_each = var.access_only ? toset([]) : local.indices
  name     = each.key

  // make sure that template is created before the data stream
  depends_on = [
    elasticstack_elasticsearch_index_template.this
  ]
}
