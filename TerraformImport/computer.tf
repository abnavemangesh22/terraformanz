
/*
resource "google_compute_instance" "mytest" {
 name = "myinstance"
 machine_type = "e2-micro"
 boot_disk {
   initialize_params {
     image = "https://www.googleapis.com/compute/v1/projects/centos-cloud/global/images/centos-7-v20220406"
   }
 }
 network_interface {
   network = "default"
 }
 allow_stopping_for_update = true
}
*/


# terraform import google_compute_instance.mytest Instance_ID


resource "google_compute_instance" "mysample1" {
  
}