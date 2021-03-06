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
      try:
        with open("/etc/hosts", "a+") as file_object:
          file_object.seek(0)
          data = file_object.read(100)
          if len(data) > 0 :
            file_object.write("\n")
          file_object.write("hello hi")
          file_object.close()
      except:
        print('authorization error, please use user with admin authorization')

      EOF
      destination = "/tmp/addshost.py"
  }

  # Execute the script remotely
  provisioner "remote-exec" {
    inline = [
      "python /tmp/addhost.py"
    ]
  }
}

# ---------lINUX---------
# provisioner "file" {
#       content = <<EOF
#       #! /bin/bash
#       ip_address="${var.ip_address_add}"
#       hostname="${var.hostname_add}"
#       host_entry= "$ip_address   $hostname"
#       echo "Adding new host entry..."
#       echo "$host_entry" >> /etc/hosts
#       EOF
#       destination = "/tmp/addshost.sh"
#   }
#   # Execute the script remotely
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/addhost.sh; bash /tmp/addhost.sh"
#     ]
#   }


#---------WINDOWS----------
# provisioner "remote-exec" {
#     inline = [  
#     "powershell.exe \"Add-Content -path C:\\windows\\System32\\drivers\\etc\\hosts -value '@{var.ip_address_add}   ${var.hostname_add}'\""
#     ]
#   }