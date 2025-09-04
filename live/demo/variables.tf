variable "project" {
  description = "Project name prefix for all resources"
  type        = string
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the RabbitMQ VM"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to your SSH public key file"
  type        = string
}

variable "container_image" {
  description = "Docker image for the Python web app"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for Key Vault"
  type        = string
}

variable "my_ip_address" {
  description = "Your public IP address to allow SSH and RabbitMQ management"
  type        = string
}
