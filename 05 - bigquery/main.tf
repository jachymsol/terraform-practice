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
  }

  required_version = "1.5.7"
}

provider "google" {
  project = "jachymsol-tf-1"
  region  = "us-central1"
}

resource "google_storage_bucket" "terraform_state" {
  name          = "jachymsol-tf-1-terraform-state"
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_bigquery_dataset" "example_dataset" {
  dataset_id    = "example_dataset"
  friendly_name = "example"
  location      = "US"
}

resource "google_bigquery_table" "test_table" {
  dataset_id    = google_bigquery_dataset.example_dataset.dataset_id
  table_id      = "table_1"
  friendly_name = "table1"
  deletion_protection = false
  schema = "[{\"name\": \"name\", \"type\": \"STRING\"}, {\"name\": \"age\", \"type\": \"NUMERIC\"}]"
}
