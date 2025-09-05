output "vm_id" {
  value = azurerm_linux_virtual_machine.this.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.this.private_ip_address
}

output "vm_public_ip" {
  value = azurerm_network_interface.this.ip_configuration[0].public_ip_address_id
}
