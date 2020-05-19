#NIC and IP for Bastion

resource "azurerm_public_ip" "bastion" {
  name                = "${var.prefix}-bastion-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}



resource "azurerm_network_interface" "bastion" {
  name                = "${var.prefix}-nic-bastion"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
  }
}


# NIC and IPs for web Node
// resource "azurerm_public_ip" "web" {
//   count               = var.web_node_count
//   name                = "${var.prefix}-${count.index}-web-pip"
//   resource_group_name = azurerm_resource_group.main.name
//   location            = azurerm_resource_group.main.location
//   allocation_method   = "Static"
//   sku                 = "Standard"
//   tags                = var.tags
// }

resource "azurerm_network_interface" "web-ubuntu" {
  count               = var.web_ubuntu_node_count
  name                = "${var.prefix}-nic-web-ubuntu-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "dynamic"
    // public_ip_address_id          = element(azurerm_public_ip.web-ubuntu-centos.*.id, count.index)
  }
}


resource "azurerm_network_interface" "web-centos" {
  count               = var.web_centos_node_count
  name                = "${var.prefix}-nic-web-centos-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "dynamic"
    // public_ip_address_id          = element(azurerm_public_ip.web-ubuntu-centos.*.id, count.index)
  }
}




# NIC and IPs for db Nodes

// resource "azurerm_public_ip" "db" {
//   count               = "${var.db_node_count}"
//   name                = "${var.prefix}-${count.index}-db-pip"
//   resource_group_name = "${azurerm_resource_group.main.name}"
//   location            = "${azurerm_resource_group.main.location}"
//   allocation_method   = "Dynamic"
//   sku                 = "Basic"
//   tags                = "${var.tags}"
// }

resource "azurerm_network_interface" "db" {
  count               = var.db_node_count
  name                = "${var.prefix}-nic-db-${count.index}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}



# PUblic IP and NIC for web Centos


#NIC and IP for web

resource "azurerm_public_ip" "web" {
  name                = "${var.prefix}-web-pip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}



resource "azurerm_network_interface" "web" {
  name                = "${var.prefix}-nic-web"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }
}
