#security Group for bastion


resource "azurerm_network_security_group" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name
}

resource "azurerm_network_security_rule" "bastion" {
  count                       = length(var.bastion_inbound_ports)
  name                        = "sgrule-bastion-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.bastion_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.project_z.name
  network_security_group_name = azurerm_network_security_group.bastion.name
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}




# Security Group for web Node

resource "azurerm_network_security_group" "web" {
  name                = "web"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name
}

resource "azurerm_network_security_rule" "web" {
  count                       = length(var.web_inbound_ports)
  name                        = "sgrule-web-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.web_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.project_z.name
  network_security_group_name = azurerm_network_security_group.web.name
}

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

# Associate web NSG To web subnet

# Security Group for db  Node
resource "azurerm_network_security_group" "db" {
  name                = "db"
  location            = azurerm_resource_group.project_z.location
  resource_group_name = azurerm_resource_group.project_z.name
}

resource "azurerm_network_security_rule" "db" {
  count                       = length(var.db_inbound_ports)
  name                        = "sgrule-db-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.db_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.project_z.name
  network_security_group_name = azurerm_network_security_group.db.name
}

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db.id
}