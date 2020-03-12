#Work in Progress
# creating one template that will work for both

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


	# Execute the script remotely
  provisioner "remote-exec" {
    inline = [  
    "powershell.exe \"Add-Content -path C:\\windows\\System32\\drivers\\etc\\hosts -value '@{var.ip_address_add}   ${var.hostname_add}'\""
    ]
  }

}