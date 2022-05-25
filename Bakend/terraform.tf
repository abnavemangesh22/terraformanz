
terraform {
  required_version = "1.1.2" # terraform client version
  required_providers {   # Provider Version
    google = {
        source = "hashicorp/google"
        version = "4.18.0"
    }
  }
  backend "gcs" {
    bucket = "mybucket-mangesh"
    prefix = "terraform/statefile"
  }
}