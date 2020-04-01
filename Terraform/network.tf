resource "azurerm_resource_group" "project_z" {
  name     = "${var.prefix}-RG"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "project_z" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name
  tags                = var.tags
}


# Public Subnet
resource "azurerm_subnet" "public" {
  name                 = "${var.prefix}-public-subnet"
  resource_group_name  = azurerm_resource_group.project_z.name
  virtual_network_name = azurerm_virtual_network.project_z.name
  address_prefix       = "10.0.0.0/24"
}


# Web Subnet

resource "azurerm_subnet" "web" {
  name                 = "${var.prefix}-web-subnet"
  resource_group_name  = azurerm_resource_group.project_z.name
  virtual_network_name = azurerm_virtual_network.project_z.name
  address_prefix       = "10.0.1.0/24"
}

# DB subnet
resource "azurerm_subnet" "db" {
  name                 = "db"
  resource_group_name  = azurerm_resource_group.project_z.name
  virtual_network_name = azurerm_virtual_network.project_z.name
  address_prefix       = "10.0.2.0/24"
}

#NIC and IP for Bastion

resource "azurerm_public_ip" "bastion" {
  name                = "${var.prefix}-bastion-pip"
  resource_group_name = azurerm_resource_group.project_z.name
  location            = azurerm_resource_group.project_z.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}



resource "azurerm_network_interface" "bastion" {
  name                = "${var.prefix}-nic-bastion"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name

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
//   resource_group_name = azurerm_resource_group.project_z.name
//   location            = azurerm_resource_group.project_z.location
//   allocation_method   = "Static"
//   sku                 = "Standard"
//   tags                = var.tags
// }

resource "azurerm_network_interface" "web" {
  count               = var.web_node_count
  name                = "${var.prefix}-nic-web-${count.index}"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "dynamic"
    // public_ip_address_id          = element(azurerm_public_ip.web.*.id, count.index)
  }
}

# NIC and IPs for db Nodes

// resource "azurerm_public_ip" "db" {
//   count               = "${var.db_node_count}"
//   name                = "${var.prefix}-${count.index}-db-pip"
//   resource_group_name = "${azurerm_resource_group.project_z.name}"
//   location            = "${azurerm_resource_group.project_z.location}"
//   allocation_method   = "Dynamic"
//   sku                 = "Basic"
//   tags                = "${var.tags}"
// }

resource "azurerm_network_interface" "db" {
  count               = var.db_node_count
  name                = "${var.prefix}-nic-db-${count.index}"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}

