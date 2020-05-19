#Fetch the Cloudinit (userdate) file

data "template_file" "web-ubuntu" {
  template = file("${path.module}/Templates/cloudnint-ubuntu.tpl")
}

data "template_file" "key_data" {
  template = file("~/.ssh/id_rsa.pub")
}

resource "azurerm_virtual_machine" "web-ubuntu" {
  count                 = var.web_ubuntu_node_count
  name                  = "${var.prefix}-web-ubuntu-${count.index}"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [element(azurerm_network_interface.web-ubuntu.*.id, count.index)]
  vm_size               = var.web_ubuntu_vm_size

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-${count.index}-web-ubuntu-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-web-ubuntu-${count.index}"
    admin_username = var.admin_username
    custom_data    = data.template_file.web-ubuntu.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = data.template_file.key_data.rendered
      path     = var.destination_ssh_key_path
    }
  }
}
