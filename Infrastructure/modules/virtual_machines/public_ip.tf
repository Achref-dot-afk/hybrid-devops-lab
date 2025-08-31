resource "azurerm_public_ip" "example" {
  name                = "jenkins-master-ip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"

  tags = {
    environment = var.environment
  }
}