resource "google_compute_network" "kube_vpc" {
  name                    = "kube-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "kube_vpc_subnet" {
  network       = google_compute_network.kube_vpc.name
  name          = "kube-subnet"
  region        = var.google_region
  ip_cidr_range = "10.10.0.0/24"
}

resource "google_compute_firewall" "kube_firewall" {
  name    = "kube-firewall"
  network = google_compute_network.kube_vpc.name

  allow {
    protocol = "TCP"
    ports    = ["80", "8080", "30000-35000"]
  }

  source_tags = ["web"]
}
