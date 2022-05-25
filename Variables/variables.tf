


# Declare the variables inside the file

variable "myvar_zone" {
  type = string
  description = "This variable will replace the zone"
  default = "asia-south1-b"
}

variable "mymachine_type" {
  type = map(string)
  description = "This is the value for machine type"
  #default = ["e2-micro", "e2-small", "e2-medium"]
  default = {
    "micro" = "e2-micro"
    "small" = "e2-small"
    "medium" = "e2-medium"
  }
}

variable "myimage_type" {
  type = string
  description = "This is the image type"
  default = "debian-cloud/debian-9"
}

/*
ariable "mycount" {
  type = number
  default = 1
}
*/


/*
variable "username" {
  type = string
  description = "This is database username"
  sensitive = true
}

variable "password" {
  type = string
  description = "This is database password"
  sensitive = true
}
*/