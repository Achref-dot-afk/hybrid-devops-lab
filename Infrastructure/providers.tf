terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.92"
    }

  }
  required_version = ">= 0.14"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  use_oidc = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id = var.client_id
}

