

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
  machine_type = var.mymachine_type["small"]
  zone = var.myvar_zone
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
 }


data "google_compute_image" "my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}


output "myimagetest" {
  value = data.google_compute_image.my_image.archive_size_bytes
}

/*
resource "google_sql_database_instance" "mydatabase" {
  name = "mydatabase-1"
  deletion_protection = false
  region = "asia-south1"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "mydbuser" {
  instance = google_sql_database_instance.mydatabase.name
  name = var.username
  password = var.password
}
*/