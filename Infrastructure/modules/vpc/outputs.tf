output "master_subnet_id" {
  value = azurerm_subnet.master_subnet.id
}

output "worker_subnet_id" {
  value = azurerm_subnet.worker_subnet.id
}