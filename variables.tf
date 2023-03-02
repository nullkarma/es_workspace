variable "name" {
  type = string
}
variable "roles" {
  type = list(string)
}
variable "auth_group" {
  type = string
}
variable "cluster_permissions" {
  type = list(string)
  default = []
}
variable "indices" {
  type = list(map(list(any)))
  default = [
    {
      names = []
      privileges = []
    }
  ]
}

variable "kibana_spaces" {
  type = list(string)
  default = []
}
variable "kibana_features" {
  type = list(string)
  default = []
}

variable "base_template" {
  default = null
}
variable "index_mapping" {
  default = null
}
