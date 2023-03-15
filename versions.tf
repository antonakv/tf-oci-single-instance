terraform {
  required_version = "= 1.3.7"
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "= 4.111.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "= 2.4.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "= 2.2.0"
    }
  }
}
