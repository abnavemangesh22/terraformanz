output "mysystem_id" {
  value = google_compute_instance.mywebserver-1.id
}

output "mysystem_name" {
  value = google_compute_instance.mywebserver-1.name
}

output "myfirewall" {
  value = google_compute_firewall.myfirewall.name
}

output "mytest" {
  value = google_compute_instance.mywebserver-1.instance_id
}
