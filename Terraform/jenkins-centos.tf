data "template_file" "jenkins" {
  template = file("${path.module}/Templates/cloudnint-jenkins.tpl")
}


resource "azurerm_virtual_machine" "jenkins" {
  name                  = "${var.prefix}-jenkins"
  location              = azurerm_resource_group.project_z.location
  resource_group_name   = azurerm_resource_group.project_z.name
  network_interface_ids = [azurerm_network_interface.jenkins.id]
  vm_size               = var.jenkins_vm_size

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-jenkins-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-jenkins"
    admin_username = var.admin_username
    custom_data    = data.template_file.jenkins.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = data.template_file.key_data.rendered
      path     = var.destination_ssh_key_path
    }
  }
}

