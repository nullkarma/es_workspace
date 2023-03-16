variable "name" {
  type = string
  description = "Universally used for all resource names"
}

variable "roles" {
  type = list(string)
  description = "Roles to attach to a role mapping"
}

variable "auth_group" {
  type = string
  description = "Used for user looking in role mapping"
}

// FIXME: The pinned version has a bug, where a provisioned role will `all` cluster permissions cannot be altered anymore.
// The role has to be destroyed and reprovisioned with a different set of cluster permissions
variable "cluster_permissions" {
  type    = list(string)
  default = []
  description = "Defines elasticsearch cluster permissions for a role."
}

variable "indices" {
  type = list(map(list(any)))
  default = [
    {
      names      = []
      privileges = []
    }
  ]
  description = "List of indices with permissions that will be attached to a role"
}

variable "kibana_spaces" {
  type    = list(string)
  default = []
  description = "one or more Kibana spaces that will be added to a role"
}

variable "kibana_features" {
  type    = list(string)
  default = ["all"]
  description = "List of features to enable for a Kibana space"
}

variable "base_template" {
  default = null
  description = "Name of the parent (master) template. Used with component templates"
}

variable "index_mapping" {
  default = null
  description = "index mapping for an index"
}
