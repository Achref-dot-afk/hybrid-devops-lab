
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-resources"
}

module "vpc" {
    source = "./modules/vpc"
    environment = var.environment
    location = var.location
    rg_name = data.azurerm_resource_group.rg
}

module "virtual_machines" {
    source = "./modules/virtual_machines"
    environment = var.environment
    location = var.location
    rg_name = data.azurerm_resource_group.rg
    master_subnet_id = module.vpc.master_subnet_id
    worker_subnet_id = module.vpc.worker_subnet_id

resource "random_pet" "name" {
    length    = 2
    separator = "-"
} 

resource "random_integer" "name" {
  max = 9999
  min = 1000
}

resource "random_pet" "f" {
  length = 5
  separator = "-"

}
