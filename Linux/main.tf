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

resource "null_resource" "vm_configuration" {
  connection {
      type     = "${var.connection_type}"
      user     = "${var.user_name}"
      password = "${var.password}"
      host     = "${var.host_ip}"
  }
  provisioner "file" {
      content = <<EOF
      #! /bin/bash
      ip_address="${var.ip_address_add}"
      hostname="${var.hostname_add}"
      host_entry= "$ip_address   $hostname"

      echo "Adding new host entry..."
      echo "$host_entry" >> /etc/hosts

      EOF
      destination = "/tmp/addshost.sh"
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/addhost.sh; bash /tmp/addhost.sh"
    ]
  }
}
