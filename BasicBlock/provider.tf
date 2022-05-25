
provider "google" {
    project = "myterraform-347615"
    zone = "asia-south1-a"
    region = "asia-south1"
}

# username and password (owner)
# First of all make sure gcloud sdk should be install
# gcloud auth application-default login
# gcloud auth list