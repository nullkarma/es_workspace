variable "teams" {
  default = {
    team = {
      roles    = []
      ad_group = ""
      features = []
      cluster_permissions = []
    }
    indices = [
      {
        names      = []
        privileges = []
      }
    ]
    spaces = []
  }
}

