terraform {
  backend "gcs" {
    bucket = "jachymsol-tf-1-terraform-state"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>5.22.0"
    }
  }

  required_version = "1.5.7"
}

provider "google" {
  project = "jachymsol-tf-1"
  region  = "us-central1"
}

resource "google_storage_bucket" "terraform_state" {
  name          = "jachymsol-tf-1-terraform-state"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
