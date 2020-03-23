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
      with open("/etc/hosts", "a+") as file_object:
        file_object.seek(0)
        data = file_object.read(100)
        if len(data) > 0 :
          file_object.write("\n")
        file_object.write("hello hi")
        file_object.close()

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
