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
    restapi = {
      source = "Mastercard/restapi"
      version = "1.18.0"
    }
    curl = {
      source  = "marcofranssen/curl"
      version = "0.2.2"
    }
  }
}
