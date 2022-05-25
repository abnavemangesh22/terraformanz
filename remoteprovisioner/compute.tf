

/* resource "google_storage_bucket" "mysamplebucket" {
  name = "mybucket-up-mangesh"
  location = "ASIA-SOUTH1"
}
*/


# To create VPC

resource "google_compute_network" "mynetwork" {
  name = "myvpc-net"
}

# To create subnet inside the VPC

resource "google_compute_subnetwork" "mysubnet-1" {
  name = "myvpc-subnet-1"
  ip_cidr_range = "10.0.0.0/24"
  network = google_compute_network.mynetwork.id
}

# public IP configuration

resource "google_compute_address" "myipaddress" {
  name = "mypublicip"
  project = "myterraform-347615"
  region = "asia-south1"
}


# Firewall configuration

resource "google_compute_firewall" "myfirewall" {
  name = "web-access"
  network = google_compute_network.mynetwork.id
  source_ranges = [ "0.0.0.0/0" ]
  allow {
    protocol = "tcp"
    ports = [ "80", "443", "22"]
  }
}

# instance configuration


resource "google_compute_instance" "mywebserver-1" {
  name = "mywebserver"
  allow_stopping_for_update = true
  machine_type = "e2-micro"
  network_interface {
  network = google_compute_network.mynetwork.id
  subnetwork = google_compute_subnetwork.mysubnet-1.id
  access_config {
    nat_ip = google_compute_address.myipaddress.address
  }
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  tags = [ "mangesh", "webserver" ]
  metadata_startup_script = "sudo apt update -y; sudo apt-get install apache2 -y; systemctl restart apache2"
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
  provisioner "file" {
    connection {
     type = "ssh"
     host = google_compute_address.myipaddress.address
     user = "ubuntu"
     private_key = file("ubuntu")
    }
    source = "key1.json"
    destination = "/tmp/key1.json"
    on_failure = continue
    }

    provisioner "remote-exec" {
      inline = [
        "sleep 120",
        "sudo cp /tmp/key1.json /tmp/newfile.json"
      ]
      connection {
        type = "ssh"
        host = google_compute_address.myipaddress.address
        user = "ubuntu"
        private_key = file("ubuntu")
      }
    }
  }

# variable declared for ssh-key

variable "ssh_public_key" {
  type = string
  default = "ubuntu.pub"
}
