# Azure Elastic UserSpace and Role Setup
 This module configures the kibana Userspaces, elasticsearch role and role mappings

[![Elastic-EC-Permissions][welcome\_image]][welcome\_link]
[![Elastic-EC-Permissions][code\_image]][code\_link]
[![Elastic-EC-Permissions][issue\_image]][issues\_link]
[![Elastic-EC-Permissions][doku\_image]][doku\_link]
[![ADR][adr\_image]][adr\_link]
[![Changelog][changelog\_image]][changelog\_link]

[welcome\_link]:             https://gowiki.gothaer.de/display/DA
[code\_link]:                https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace
[issues\_link]:              https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/issues
[doku\_link]:                https://www.terraform.io/docs/index.html
[changelog\_link]:           https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/-/blob/main/CHANGELOG.md
[adr\_link]:                 https://aprdgitlab000.analytics.gothaer.de/da/cloud/modules/elastic-workplace/-/blob/main/README.md
[welcome\_image]:            https://img.shields.io/badge/Project-welcome-blue.svg
[code\_image]:               https://img.shields.io/badge/Terraform_CI-code-green.svg
[issue\_image]:              https://img.shields.io/badge/Terraform_CI-issues-red.svg
[doku\_image]:               https://img.shields.io/badge/Terraform_CI-DOKU-yellow.svg
[adr\_image]:                https://img.shields.io/badge/Terraform_CI-ADR-yellow.svg
[changelog\_image]:          https://img.shields.io/badge/Terraform_CI-Changelog-purple.svg

## Documentation

A module to customize your ...

 https://registry.terraform.io/providers/elastic/ec/latest/docs

## Parameters

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_curl"></a> [curl](#requirement\_curl) | 0.2.2 |
| <a name="requirement_elasticstack"></a> [elasticstack](#requirement\_elasticstack) | 0.5.0 |
| <a name="requirement_kibana"></a> [kibana](#requirement\_kibana) | 8.5.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_elasticstack"></a> [elasticstack](#provider\_elasticstack) | 0.5.0 |
| <a name="provider_kibana"></a> [kibana](#provider\_kibana) | 8.5.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [elasticstack_elasticsearch_component_template.this](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_component_template) | resource |
| [elasticstack_elasticsearch_data_stream.this](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_data_stream) | resource |
| [elasticstack_elasticsearch_index_lifecycle.this](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_index_lifecycle) | resource |
| [elasticstack_elasticsearch_index_template.this](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_index_template) | resource |
| [elasticstack_elasticsearch_security_role_mapping.this](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_security_role_mapping) | resource |
| [kibana_role.this](https://registry.terraform.io/providers/disaster37/kibana/8.5.2/docs/resources/role) | resource |
| [kibana_user_space.this](https://registry.terraform.io/providers/disaster37/kibana/8.5.2/docs/resources/user_space) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_only"></a> [access\_only](#input\_access\_only) | Only provision roles and role mappings. Do not create data views and index templates. Commonly used for admins and ingest users | `bool` | `false` | no |
| <a name="input_all_privileges"></a> [all\_privileges](#input\_all\_privileges) | Grants all Kibana role privileges to a group. shortcut for passing all possible privileges in a list | `bool` | `false` | no |
| <a name="input_auth_group"></a> [auth\_group](#input\_auth\_group) | Used for user looking in role mapping | `string` | n/a | yes |
| <a name="input_base_template"></a> [base\_template](#input\_base\_template) | Name of the parent (master) template. Used with component templates | `any` | `null` | no |
| <a name="input_cluster_permissions"></a> [cluster\_permissions](#input\_cluster\_permissions) | Defines elasticsearch cluster permissions for a role. | `list(string)` | `[]` | no |
| <a name="input_delete_index_after"></a> [delete\_index\_after](#input\_delete\_index\_after) | Defines the retention period of an index in days | `string` | `"30d"` | no |
| <a name="input_index_mapping"></a> [index\_mapping](#input\_index\_mapping) | index mapping for an index | `any` | `null` | no |
| <a name="input_index_max_size"></a> [index\_max\_size](#input\_index\_max\_size) | Determines the max size of an index to trigger the ilm rollover | `string` | `"10gb"` | no |
| <a name="input_index_min_age"></a> [index\_min\_age](#input\_index\_min\_age) | Defines how long an index stays in the hot phase before getting rolled over | `string` | `"7d"` | no |
| <a name="input_indices"></a> [indices](#input\_indices) | List of indices with permissions that will be attached to a role | `list(any)` | <pre>[<br>  {<br>    "name": "",<br>    "privileges": []<br>  }<br>]</pre> | no |
| <a name="input_kibana_features"></a> [kibana\_features](#input\_kibana\_features) | List of features to enable for a Kibana space | `list(string)` | `[]` | no |
| <a name="input_kibana_spaces"></a> [kibana\_spaces](#input\_kibana\_spaces) | one or more Kibana spaces that will be added to a role | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Universally used for all resource names | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles to attach to a role mapping | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_team"></a> [team](#output\_team) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
