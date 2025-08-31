resource "azurerm_virtual_network" "customVNet" {
  name = "${var.environment}-Vnet"
  resource_group_name = var.rg_name
  location = var.location
  address_space = ["10.0.0.0/16"]
}

