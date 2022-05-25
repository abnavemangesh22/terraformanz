
# To create VPC :

resource "google_compute_network" "mynetwork-new" {
  name = "myvpc-net"
}


# To create the subnet :

resource "google_compute_subnetwork" "mysubnet-1" {
  name = "myvpc-subnet-1"
  ip_cidr_range = "10.0.0.0/24"
  network = google_compute_network.mynetwork-new.id
}


# To Create the firewall 

resource "google_compute_firewall" "myfirewall" {
  name = "web-access"
  network =  google_compute_network.mynetwork-new.id
  source_ranges = [ "0.0.0.0/0" ]
  allow {
    protocol = "tcp"
    ports = [ "80", "443", "22" ]
  }
}


# Public IP Address Configuration

resource "google_compute_address" "myipaddress" {
  name = "mypublicip"
  project = "myterraform-347615"
  region = "asia-south1"
}



# To create the machine now

resource "google_compute_instance" "mywebserver-1" {
  name = "mywebserver"
  allow_stopping_for_update = true
  machine_type = "e2-micro"
  network_interface {
    network =  google_compute_network.mynetwork-new.id
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
  tags = [ "webserver", "demotag" ]
  metadata_startup_script = "sudo apt-get update -y"
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }


# This is a file provisioner

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

# this is remote exec provisioner
provisioner "remote-exec" {
  inline = [
    "sleep 60",
    "sudo cp /tmp/key1.json /var/newfiles.json"
  ]
  connection {
    type = "ssh"
    host = google_compute_address.myipaddress.address
    user = "ubuntu"
    private_key = file("ubuntu")
  }
}


# this is the local provisioner

provisioner "local-exec" {
 command = "echo My instance would be create >> instancecreate.txt"
}

}

# Let me write the output block

output "myoutput" {
  value = google_compute_instance.mywebserver-1.instance_id
}

output "myipout" {
  value = google_compute_address.myipaddress.address
}



#variable for ssh_keys

variable "ssh_public_key" {
  type = string
  default = "ubuntu.pub"
}


