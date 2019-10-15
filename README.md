add-host terraform module


A terraform module to add a host to the /etc/hosts file in linux vm or \windows\System32\drivers\etc\hosts file in windows vm.

Module Input Variables

    connection_type - defines the tipe of connection being used to connect to vm. Usually ssh for linux and winrm for windows. 
    user_name - username used for vm being targeted
    password - password used for vm beng targeted
    host_ip - ip address of vm
    ip_address_add - ip address to add to hosts file
    hostname_add - hostname to add to hosts file
    

Usage

dowload or clone repo and access prefered folder (linux or Windows) in Terminal/Command Line.

run `terraform init` to initialize terraform

run `terraform plan` to plan terraform module (it will ask you to manually define each variable)

run `terraform apply` to excecute terraform module and apply changes

