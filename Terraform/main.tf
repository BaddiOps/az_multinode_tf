provider "azurerm" {
  version         = "~>2.1"
    features {
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.prefix
  location = var.location
  tags     = var.tags
}
