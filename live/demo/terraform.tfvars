# General project settings
project              = "py-rabbitmq-demo"
location             = "eastus"
resource_group_name  = "rg-py-rabbitmq-demo"

# VM admin settings
admin_username  = "azureuser"
ssh_public_key  = "~/.ssh/id_rsa.pub"   # Path to your SSH public key

# App Service container image
container_image = "mydockerhubuser/python-webapp:latest"

# Azure AD tenant ID (needed for Key Vault)
tenant_id = "00000000-0000-0000-0000-000000000000"
