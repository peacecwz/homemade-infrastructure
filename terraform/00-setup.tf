terraform {
  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "~> 0.0.4" # Use the latest available version
    }
  }
  required_version = ">= 0.13"
}
