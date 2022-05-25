

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

# And add the virtual into that 

resource "google_compute_instance" "myinstance" {
  name = "mydbserver"
  machine_type = "e2-small"
  zone = "asia-south1-b"
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.mynetwork.id
    subnetwork = google_compute_subnetwork.mysubnet-1.id
    access_config {}
  }
  tags = [ "mangesh", "webserver" ]
  }



/*
# for_each meta argument with Map base method

resource "google_storage_bucket" "mybucket-each" {
  for_each = {
    test1 = "testingenv-0001"
    dev1 = "development-0001"
  }
  name = "${each.key}-${each.value}"
  location = "ASIA-SOUTH1"
}
*/

/*
resource "google_storage_bucket" "mybucket-string" {
  for_each = toset(["mydevelop-0007", "mytest-0007", "myoperations-007"])
  name = "${each.key}"
  location = "ASIA-SOUTH1"
}
*/

