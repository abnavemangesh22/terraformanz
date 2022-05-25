resource "google_compute_firewall" "myfirewall" {
  name = "web-access"
  network = "default"
  source_ranges = [ "0.0.0.0/0" ]
  allow {
    protocol = "tcp"
    ports = [ "80", "443" ]
  }
}

resource "google_compute_instance" "mywebserver-1" {
  name = "mywebserver"
  allow_stopping_for_update = true
  machine_type = "e2-micro"
  network_interface {
    network = "default"
    access_config {}
  }
  boot_disk {
    initialize_params {
      image = data.google_compute_image.my_image.self_link
    }
  }
  tags = [ "mangesh", "webserver" ]
  metadata_startup_script = "sudo apt update -y; sudo apt-get install apache2 -y; systemctl restart apache2"
  provisioner "local-exec" {
  when = destroy
  command = "echo mytest >> mylocalfile.txt"
  }
}


data "google_compute_image" "my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

