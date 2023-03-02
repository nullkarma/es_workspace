# Kibana & Elasticsearch provisioning

- Creates Kibana space
- Creates Elasticsearch role
- Manages Elasticsearch role mapping for non-native authc realms
- Manages Kibana features and Elasticsearch role permissions
- Manages index permissions
- Manages index templates

# Examples

Check the examples folder where you can see how to configure the module

# Usage

Kibana permissions and cluster permissions can be taken from the Kibana webui in `stack management => roles` or the [kibana API](https://www.elastic.co/guide/en/kibana/current/features-api-get.html) itself.
Empty permission (kibana features, cluster permissions, roles) lists result in no access.

# inputs

| Name                | Description                                                    | Type                     | Default        | Required |
|---------------------|----------------------------------------------------------------|--------------------------|----------------|----------|
| name                | Used for role, mapping and space name                          | `string`                 | `""`           | true     |
| roles               | A list of roles the role mapping should be attached to         | `list(string)`           | `[]`           | true     |
| auth_group          | Reference to the user lookup. For example AD group string      | `string`                 | `""`           | true     |
| cluster_permissions | Interaction with the ES cluster API                            | `list`                   | `[]`           | false    |
| indices             | List of indices and their permission for that particular group | `list(map(list(string))) | see varibables | true     |
| kibana_spaces       | List of kibana space the group has access to                   | `list(string)            | `[]`           |false|
| kibana_features     | Which kibana features to enable                                | `list(string)            | `[]`           | false    |
| base_template       | base template with index settings & mappings                   | string                   | `Null`         | false    |
| index_mapping       | Composition Template with index mapping                        | string                   | `Null`         | false    |