terraform {
  required_version = ">=1.1.5"

  required_providers {
    kustomization = {
      source  = "kbst/kustomization"
      version = "0.9.0"
    }
    flux = {
      source = "fluxcd/flux"
    }
    kind = {
      source  = "tehcyx/kind"
      version = ">=0.0.16"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
  }
}
