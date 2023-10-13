data "flux_install" "main" {
  target_path = "flux-system"
}

data "flux_sync" "main" {
  url         = "https://github.com/<GITHUB_USERNAME>/<GITHUB_REPO_NAME>"
  target_path = "flux-system"
  branch      = "main"
  path        = "./clusters/my-cluster"
}

resource "kustomization_resource" "install" {
  for_each = data.flux_install.main
  manifest = each.value
}

resource "kustomization_resource" "sync" {
  for_each = data.flux_sync.main
  manifest = each.value
}
