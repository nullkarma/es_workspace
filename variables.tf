// Universally used for all resource names
variable "name" {
  type = string
}

// Roles to attach to a role mapping
variable "roles" {
  type = list(string)
}

// Used for user looking in role mapping
variable "auth_group" {
  type = string
}

// Defines elasticsearch cluster permissions for a role
// FIXME: The pinned version has a bug, where a provisioned role will `all` cluster permissions cannot be altered anymore.
// The role has to be destroyed and reprovisioned with a different set of cluster permissions
variable "cluster_permissions" {
  type    = list(string)
  default = []
}

// List of indices with permissions that will be attached to a role
variable "indices" {
  type = list(map(list(any)))
  default = [
    {
      names      = []
      privileges = []
    }
  ]
}

// one or more Kibana spaces that will be added to a role
variable "kibana_spaces" {
  type    = list(string)
  default = []
}

// List of features to enable for a Kibana space
variable "kibana_features" {
  type    = list(string)
  default = ["all"]
}

// Name of the parent (master) template. Used with component templates
variable "base_template" {
  default = null
}

// index mapping for an index
variable "index_mapping" {
  default = null
}
