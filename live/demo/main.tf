terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
}

# -------------------------
# Resource Group
# -------------------------
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

# -------------------------
# Network Module
# -------------------------
module "network" {
  source              = "../../modules/network"
  name                = "${var.project}-net"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  address_space = ["10.0.0.0/16"]

  subnet_prefixes = {
    app = ["10.0.1.0/24"]
  }
}

# -------------------------
# Key Vault Module
# -------------------------
module "keyvault" {
  source              = "../../modules/keyvault"
  name                = "${var.project}-kv"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = var.tenant_id
}

# Generate a random RabbitMQ password
resource "random_password" "rabbitmq" {
  length  = 16
  special = true
}

# Store RabbitMQ password in Key Vault
resource "azurerm_key_vault_secret" "rabbitmq_password" {
  name         = "rabbitmq-password"
  value        = random_password.rabbitmq.result
  key_vault_id = module.keyvault.keyvault_id
}

# -------------------------
# RabbitMQ VM Module
# -------------------------
module "rabbitmq_vm" {
  source              = "../../modules/vm"
  name                = "${var.project}-rabbitmq"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = module.network.subnet_ids["app"]
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  vm_size             = "Standard_B1s"    # ✅ free tier eligible
  cloud_init_file     = "${path.module}/cloud-init-rabbitmq.yaml"
  allowed_ssh_ip      = var.my_ip_address # 🔑 restrict SSH
}

# -------------------------
# App Service Module
# -------------------------
module "app_service" {
  source              = "../../modules/app_service"
  name                = "${var.project}-app"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name

  container_image = var.container_image

  app_settings = {
    RABBITMQ_HOST     = module.rabbitmq_vm.vm_private_ip
    RABBITMQ_USER     = "admin"
    RABBITMQ_PASSWORD = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.rabbitmq_password.versionless_id})"
  }
}

# -------------------------
# Outputs
# -------------------------
output "app_service_url" {
  value = module.app_service.app_service_url
}

output "rabbitmq_vm_private_ip" {
  value = module.rabbitmq_vm.vm_private_ip
}

output "rabbitmq_vm_public_ip" {
  value = module.rabbitmq_vm.vm_public_ip
}

output "keyvault_uri" {
  value = module.keyvault.keyvault_uri
}
