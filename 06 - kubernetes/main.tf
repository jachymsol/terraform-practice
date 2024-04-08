terraform {
  backend "gcs" {
    bucket = "jachymsol-tf-1-terraform-state"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.22.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27.0"
    }
  }

  required_version = "1.5.7"
}

provider "google" {
  project = "jachymsol-tf-1"
  region  = "us-central1"
}

provider "kubernetes" {
  # host = google_container_cluster.tf_cluster.cluster_ipv4_cidr

  # cluster_ca_certificate = google_container_cluster.tf_cluster.master_auth.0.cluster_ca_certificate
}

resource "google_storage_bucket" "terraform_state" {
  name          = "jachymsol-tf-1-terraform-state"
  location      = "US"
  force_destroy = false
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
