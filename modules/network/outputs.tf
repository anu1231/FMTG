output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet names to IDs"
  value       = { for k, s in azurerm_subnet.this : k => s.id }
}
