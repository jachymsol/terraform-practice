terraform {
  backend "gcs" {
    bucket = "jachymsol-tf-1-terraform-state"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.22.0"
    }
    terraform = {
      source = "hashicorp/kubernetes"
      version = "~> 2.27.0"
    }
  }
  required_version = "1.5.7"
}
