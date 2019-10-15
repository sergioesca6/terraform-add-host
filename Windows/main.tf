resource "null_resource" "vm_configuration" {
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
