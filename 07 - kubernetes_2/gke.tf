resource "google_container_cluster" "tf_cluster" {
  name     = "tf-cluster"
  location = var.google_region

  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

  network    = google_compute_network.kube_vpc.name
  subnetwork = google_compute_subnetwork.kube_vpc_subnet.name
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "tf-node-pool"
  cluster    = google_container_cluster.tf_cluster.name
  location   = var.google_region
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}
