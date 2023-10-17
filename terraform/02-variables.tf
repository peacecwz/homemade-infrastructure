variable "clusters" {
  description = "Configuration for each Kubernetes cluster"
  type = list(object({
    env                 = string
    name                = string
    worker_count        = number
    control_plane_count = number
    kubeadm_config      = string
    extra_ports = list(object({
      container_port = number
      host_port      = number
      listen_address = string
      protocol       = string
    }))
  }))
  default = []
}

variable "github_token" {
  sensitive = true
  type      = string
}

variable "github_org" {
  type = string
}

variable "github_repository" {
  type = string
}
