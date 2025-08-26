resource "azurerm_storage_account" "example" {
  name                     = "examplestorageacc"
  resource_group_name      = "rg-test"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Allow"  # misconfiguration, should be "Deny" for private access
    bypass         = ["AzureServices"]
  }
}