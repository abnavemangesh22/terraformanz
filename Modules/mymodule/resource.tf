

resource "google_compute_instance" "myinstance1" {
  name = "myweb"
  allow_stopping_for_update = true
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  metadata_startup_script = "sudo apt update -y; sudo apt-get install apache2 -y; systemctl restart apache2"
  network_interface {
    network = "default"
    access_config {
      
    }
  }
}