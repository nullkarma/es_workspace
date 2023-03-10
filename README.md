## Requirements

| Name | Version |
|------|---------|
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
| [elasticstack_elasticsearch_component_template.ct](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_component_template) | resource |
| [elasticstack_elasticsearch_index_template.template](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_index_template) | resource |
| [elasticstack_elasticsearch_security_role_mapping.rm](https://registry.terraform.io/providers/elastic/elasticstack/0.5.0/docs/resources/elasticsearch_security_role_mapping) | resource |
| [kibana_role.role](https://registry.terraform.io/providers/disaster37/kibana/8.5.2/docs/resources/role) | resource |
| [kibana_user_space.userspace](https://registry.terraform.io/providers/disaster37/kibana/8.5.2/docs/resources/user_space) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_group"></a> [auth\_group](#input\_auth\_group) | Used for user looking in role mapping | `string` | n/a | yes |
| <a name="input_base_template"></a> [base\_template](#input\_base\_template) | Name of the parent (master) template. Used with component templates | `any` | `null` | no |
| <a name="input_cluster_permissions"></a> [cluster\_permissions](#input\_cluster\_permissions) | Defines elasticsearch cluster permissions for a role | `list(string)` | `[]` | no |
| <a name="input_index_mapping"></a> [index\_mapping](#input\_index\_mapping) | index mapping for an index | `any` | `null` | no |
| <a name="input_indices"></a> [indices](#input\_indices) | List of indices with permissions that will be attached to a role | `list(map(list(any)))` | <pre>[<br>  {<br>    "names": [],<br>    "privileges": []<br>  }<br>]</pre> | no |
| <a name="input_kibana_features"></a> [kibana\_features](#input\_kibana\_features) | List of features to enable for a Kibana space | `list(string)` | `[]` | no |
| <a name="input_kibana_spaces"></a> [kibana\_spaces](#input\_kibana\_spaces) | one or more Kibana spaces that will be added to a role | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Universally used for all resource names | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | Roles to attach to a role mapping | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_team"></a> [team](#output\_team) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
