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
    node {
      role = "control-plane"
    }
    dynamic "node" {
      for_each = range(var.clusters[count.index].control_plane_count)
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
