resource "google_compute_instance" "sample_instance" {
  name         = "sample-instance-1"
  zone         = "us-central1-a"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
}
