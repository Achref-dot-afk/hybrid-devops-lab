terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }

  }
  required_version = ">= 0.14"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  use_oidc = true
  subscription_id = var.subscription_id
  client_id = var.client_id
}

