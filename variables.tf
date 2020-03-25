variable "connection_type" {
  description = "defines the tipe of connection being used to connect to vm"
}

variable "user_name" {
    description = "username used for vm"
}

variable "password" {
    description = "password used for vm"
}

variable "host_ip" {
    description = "ip address of vm"
}

variable "ip_address_add" {
    description = "ip address to add to hosts file"
}
variable "hostname_add" {
    description = "hostname to add to hosts file"
}
