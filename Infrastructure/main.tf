
data "azurerm_resource_group" "rg" {
  name = "rg-terraform-resources"
}

module "vpc" {
    source = "./modules/vpc"
    environment = var.environment
    location = var.location
    rg_name = data.azurerm_resource_group.rg.name
}

module "virtual_machines" {
    source = "./modules/virtual_machines"
    environment = var.environment
    location = var.location
    rg_name = data.azurerm_resource_group.rg.name
    master_subnet_id = module.vpc.master_subnet_id
    worker_subnet_id = module.vpc.worker_subnet_id
    nsg_rules = var.nsg_rules
}