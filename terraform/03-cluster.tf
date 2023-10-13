resource "random_pet" "cluster_name_suffix" {
  count     = length(var.clusters)
  length    = 1
  separator = "-"
}

resource "null_resource" "kind_create_cluster" {
  count = length(var.clusters)

  provisioner "local-exec" {
    command = <<EOT
      cat <<EOF | kind create cluster --name=${var.clusters[count.index].env}-${var.clusters[count.index].name}-${random_pet.cluster_name_suffix[count.index].id} --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
$(for i in $(seq 2 ${var.clusters[count.index].control_plane_count}); do echo "- role: control-plane"; done)
$(for i in $(seq 1 ${var.clusters[count.index].worker_count}); do echo "- role: worker"; done)
EOF
    EOT
  }

  triggers = {
    always_run   = "${timestamp()}"
    cluster_name = "${var.clusters[count.index].env}-${var.clusters[count.index].name}-${random_pet.cluster_name_suffix[count.index].id}"
  }

  depends_on = [random_pet.cluster_name_suffix]
}

resource "null_resource" "kind_delete_cluster" {
  count = length(var.clusters)

  provisioner "local-exec" {
    when    = destroy
    command = "kind delete cluster --name=${self.triggers.cluster_name}"
  }

  triggers = {
    always_run   = "${timestamp()}"
    cluster_name = "${var.clusters[count.index].env}-${var.clusters[count.index].name}-${random_pet.cluster_name_suffix[count.index].id}"
  }

  depends_on = [null_resource.kind_create_cluster]
}
