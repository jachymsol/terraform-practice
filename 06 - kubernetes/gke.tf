resource "google_container_cluster" "tf_cluster" {
  name     = "tf-cluster"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "tf-node-pool"
  location   = "us-central1"
  cluster    = google_container_cluster.tf_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
