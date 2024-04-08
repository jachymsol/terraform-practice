provider "google" {
  project = var.google_project
  region  = var.google_region
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.tf_cluster.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.tf_cluster.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}
