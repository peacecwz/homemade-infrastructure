variable "clusters" {
  description = "Configuration for each Kubernetes cluster"
  type = list(object({
    env                 = string
    name                = string
    worker_count        = number
    control_plane_count = number
  }))
  default = []
}
