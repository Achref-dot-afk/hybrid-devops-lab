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
}

