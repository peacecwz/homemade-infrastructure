resource "random_pet" "cluster_name_suffix" {
  count     = length(var.clusters)
  length    = 1
  separator = "-"
}

resource "kind_cluster" "this" {
  count = length(var.clusters)

  name = "${var.clusters[count.index].env}-${var.clusters[count.index].name}-${random_pet.cluster_name_suffix[count.index].id}"
  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"
    # networking {
    #   api_server_port    = 6443
    #   api_server_address = "127.0.0.1"
    #   service_subnet     = "127.0.0.1/24"
    # }
    node {
      role = "control-plane"
      extra_port_mappings {
        container_port = 80
        host_port      = 80
        listen_address = "127.0.0.1"
        protocol       = "TCP"
      }
    }
    dynamic "node" {
      for_each = var.clusters[count.index].control_plane_count > 1 ? range(var.clusters[count.index].control_plane_count) : []
      content {
        role = "control-plane"
      }
    }
    dynamic "node" {
      for_each = range(var.clusters[count.index].worker_count)
      content {
        role = "worker"
      }
    }
  }

  wait_for_ready = true
  depends_on     = [random_pet.cluster_name_suffix]
}
