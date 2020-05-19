output "bastion_ip" {
    value = azurerm_public_ip.bastion.ip_address
}


output "jenkisn_ip" {
    value = azurerm_public_ip.web.ip_address
}




output "bastion_private_ip" {

    value = azurerm_network_interface.bastion.private_ip_address
}



output "web_ip" {

    value = [azurerm_network_interface.web.*.private_ip_address]
}

output "db_ip" {
    value = [azurerm_network_interface.db.*.private_ip_address]
}