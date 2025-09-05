output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "Subnet ID for applications"
  value       = azurerm_subnet.apps.id
}
