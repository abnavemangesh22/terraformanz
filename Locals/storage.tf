
/*
resource "google_storage_bucket" "mybucket" {
  count = 4
  name = "mybucket-app-${count.index}"
  location = "ASIA-SOUTH1"
  storage_class = "REGIONAL"
}

output "myvalue" {
 value = ["${google_storage_bucket.mybucket.*.name}"]
}
*/


locals {
  name = "my-destination"
}

resource "google_compute_instance" "myresource" {
  name = local.name
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-9"
    }
  }
  network_interface {
    network = "default"
  }
}