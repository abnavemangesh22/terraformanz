terraform {
  required_version = "~> 1.1.2"
  required_providers {
    google =  {
      source = "hashicorp/google"
      version = "4.17.0"
    }
    aws = {
    source = "hashicorp/aws"
    version = "4.10.0"
  }
 }
}