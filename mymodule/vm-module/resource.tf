
resource "google_compute_instance" "myresource" {
  name = var.mymachine_name
  allow_stopping_for_update = true
  machine_type = var.mymachine_type
  zone = "asia-south1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
   network_interface {
    network = "default"
    access_config {}
  }

}