# Work in Progress
# creating one template that will work for both
# Add a conditional statement or run both on vm
resource "null_resource" "vm_configuration_linux" {
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

resource "null_resource" "vm_configuration_windows" {
  connection {
      type     = "${var.connection_type}"
      user     = "${var.user_name}"
      password = "${var.password}"
      host     = "${var.host_ip}"
  }
	# Execute the script remotely
  provisioner "remote-exec" {
    inline = [  
    "powershell.exe \"Add-Content -path C:\\windows\\System32\\drivers\\etc\\hosts -value '@{var.ip_address_add}   ${var.hostname_add}'\""
    ]
  }

}