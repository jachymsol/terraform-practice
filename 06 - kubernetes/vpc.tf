resource "google_compute_network" "kube_vpc" {
  name                    = "kube-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kube_vpc_subnet" {
  name          = "kube-subnet"
  region        = "us-central1"
  network       = google_compute_network.kube_vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
