variable "team_name" {}
variable "roles" {}
variable "ad_group" {}
variable "cluster_permissions" {}
variable "indices" {
  default = [
    {
      names = []
      privileges = []
    }
  ]
}

variable "kibana_spaces" {}
variable "kibana_features" {}

variable "base_template" {}
variable "index_mapping" {}
