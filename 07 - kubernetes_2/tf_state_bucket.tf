resource "google_storage_bucket" "terraform_state" {
  name          = "jachymsol-tf-1-terraform-state"
  storage_class = "STANDARD"
  force_destroy = false
  location      = "US"
  versioning {
    enabled = true
  }
}