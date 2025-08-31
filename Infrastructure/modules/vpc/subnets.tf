resource "azurerm_subnet" "master_subnet" {
  name = "${var.environment}-master-subnet"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.customVNet.name
  address_prefixes = ["10.0.1.0/24"]

}

resource "azurerm_subnet" "worker_subnet" {
  name = "${var.environment}-worker-subnet"
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.customVNet.name
  address_prefixes = ["10.0.10.0/24"]

}