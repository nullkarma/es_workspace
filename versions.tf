terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.5.0"
    }
    kibana = {
      source  = "disaster37/kibana"
      version = "8.5.2"
    }
  }
}
