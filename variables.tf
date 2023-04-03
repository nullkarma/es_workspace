variable "name" {
  type        = string
  description = "Universally used for all resource names"
}

variable "access_only" {
  default     = false
  description = "Only provision roles and role mappings. Do not create data views and index templates. Commonly used for admins and ingest users"
}

variable "all_privileges" {
  default     = false
  description = "Grants all Kibana role privileges to a group. shortcut for passing all possible privileges in a list"
}

variable "roles" {
  type        = list(string)
  description = "Roles to attach to a role mapping"
}

variable "auth_group" {
  type        = string
  description = "Used for user looking in role mapping"
}

// FIXME: The pinned version has a bug, where a provisioned role will `all` cluster permissions cannot be altered anymore.
// The role has to be destroyed and reprovisioned with a different set of cluster permissions
variable "cluster_permissions" {
  type        = list(string)
  default     = []
  description = "Defines elasticsearch cluster permissions for a role."
}

variable "indices" {
  type = list(any)
  default = [
    {
      name       = ""
      privileges = []
    }
  ]
  description = "List of indices with permissions that will be attached to a role"
}

variable "kibana_spaces" {
  type        = list(string)
  default     = []
  description = "one or more Kibana spaces that will be added to a role"
}

variable "kibana_features" {
  type        = list(string)
  default     = []
  description = "List of features to enable for a Kibana space"
}

variable "base_template" {
  type = string
  default = null
  description = "Name of the parent (master) template. Used with component templates"
}

variable "index_mapping" {
  default     = null
  description = "index mapping for an index"
}

variable "delete_index_after" {
  type = string
  default     = "30d"
  description = "Defines the retention period of an index in days"
}

variable "index_min_age" {
  type = string
  default     = "7d"
  description = "Defines how long an index stays in the hot phase before getting rolled over"
}

variable "index_max_size" {
  type = string
  default     = "10gb"
  description = "Determines the max size of an index to trigger the ilm rollover"
}
