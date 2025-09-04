terraform {
subnet_name = var.subnet_name
address_space = "10.1.0.0/16"
subnet_prefix = "10.1.1.0/24"
nsg_name = "nsg-apps"
security_rules = [
{
name = "Allow-SSH"
priority = 100
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "22"
source_address_prefix = "Internet"
destination_address_prefix = "*"
},
{
name = "Allow-HTTP"
priority = 200
direction = "Inbound"
access = "Allow"
protocol = "Tcp"
source_port_range = "*"
destination_port_range = "80"
source_address_prefix = "Internet"
destination_address_prefix = "*"
}
]
}


# Key Vault
module "kv" {
source = "../../modules/keyvault"
name = "kv-demo-12345"
location = azurerm_resource_group.this.location
resource_group_name = azurerm_resource_group.this.name
}


# App Service (containerized Python app)
module "app" {
source = "../../modules/app_service"
location = azurerm_resource_group.this.location
resource_group_name = azurerm_resource_group.this.name
app_name = var.app_name
acr_name = var.acr_name
container_image = var.container_image
plan_name = "plan-${var.app_name}"
sku_tier = "Basic"
sku_size = "B1"
start_command = null
extra_app_settings = {
"RABBITMQ_HOST" = "${module.rabbitmq_private_ip}"
}
}


# RabbitMQ VM (uses generic VM module)
module "rabbitmq" {
source = "../../modules/vm"
name = var.rabbit_vm_name
location = azurerm_resource_group.this.location
resource_group_name = azurerm_resource_group.this.name
vm_size = var.rabbit_vm_size
admin_username = var.admin_username
ssh_public_key = var.ssh_public_key
subnet_id = module.network.subnet_id
public_ip_id = null
custom_data = base64encode(file("./cloudinit/rabbitmq-cloudinit.yaml"))
image_publisher = "Canonical"
image_offer = "0001-com-ubuntu-server-focal"
image_sku = "20_04-lts"
}


# Outputs
output "app_default_hostname" {
value = module.app.app_default_hostname
}


output "rabbitmq_private_ip" {
value = module.rabbitmq.private_ip
}