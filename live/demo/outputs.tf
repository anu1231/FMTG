output "app_service_url" {
  description = "URL of the deployed Python web application"
  value       = module.app_service.app_service_url
}

output "rabbitmq_vm_private_ip" {
  description = "Private IP address of the RabbitMQ VM"
  value       = module.rabbitmq_vm.vm_private_ip
}

output "rabbitmq_vm_public_ip" {
  description = "Public IP address of the RabbitMQ VM (for SSH and management access)"
  value       = module.rabbitmq_vm.vm_public_ip
}

output "keyvault_uri" {
  description = "Key Vault URI where secrets are stored"
  value       = module.keyvault.keyvault_uri
}
