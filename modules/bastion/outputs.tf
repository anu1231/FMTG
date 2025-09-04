output "bastion_host_id" {
  description = "ID of the Bastion host"
  value       = azurerm_bastion_host.this.id
}

output "bastion_public_ip" {
  description = "Public IP of the Bastion host"
  value       = azurerm_public_ip.this.ip_address
}
