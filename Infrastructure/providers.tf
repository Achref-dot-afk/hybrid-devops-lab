terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.37.0"
    }

  }
  required_version = ">= 0.14"
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  use_oidc = true
}

