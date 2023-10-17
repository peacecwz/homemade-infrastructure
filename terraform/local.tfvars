clusters = [
  {
    env                 = "local"
    name                = "apps"
    worker_count        = 1
    control_plane_count = 1
    kubeadm_config      = <<EOF
|
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    node-labels: "ingress-ready=true"
EOF
    extra_ports = [
      {
        container_port = 80
        host_port      = 80
        listen_address = "127.0.0.1"
        protocol       = "TCP"
      },
      {
        container_port = 443
        host_port      = 443
        listen_address = "127.0.0.1"
        protocol       = "TCP"
      }
    ]
  }
]
