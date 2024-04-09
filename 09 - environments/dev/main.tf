terraform {
  backend "gcs" {
    bucket = "jachymsol-tf-1-terraform-state"
    prefix = "terraform/state-dev"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.22.0"
    }
  }
  required_version = "1.5.7"
}

provider "google" {
  project = "jachymsol-tf-1"
  region  = "us-central1"
}

module "nginx" {
  source = "../modules/nginx"
  env    = "dev"
}
