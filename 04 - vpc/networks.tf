resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network-1"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet_central" {
  name          = "vpc-subnet-1"
  ip_cidr_range = "10.128.0.0/20"
  network       = google_compute_network.vpc_network.self_link
  region        = "us-central1"
}

resource "google_compute_subnetwork" "vpc_subnet_west" {
  name          = "vpc-subnet-2"
  ip_cidr_range = "10.132.0.0/20"
  network       = google_compute_network.vpc_network.self_link
  region        = "us-west1"
}
