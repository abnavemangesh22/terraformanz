
provider "google" {
    project = "myterraform-347615"
    zone = "asia-south1-a"
    region = "asia-south1"
    credentials = "key1.json"
}

 provider "google" {
  project = "myterraform-347615"
  zone = "asia-south1-b"
  region = "asia-south1"
  credentials = "key1.json"
  alias = "google-south-b"
}




# I will create Service Account ion GCP
# I will create the key for the service account and download that key on you project folder