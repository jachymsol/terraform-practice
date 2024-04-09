resource "google_compute_instance" "nginx" {
  name = "nginx-${var.env}"
  machine_type = "e2-micro"
  zone = "us-central1-a"
  boot_disk {
   initialize_params {
     image = "debian-cloud/debian-11"
   } 
  }
  network_interface {
    network = "default"
    access_config {
      
    }
  }
}