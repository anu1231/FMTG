project              = "py-rabbitmq-demo"
location             = "eastus"
resource_group_name  = "rg-py-rabbitmq-demo"

admin_username  = "azureuser"
ssh_public_key  = "~/.ssh/id_rsa.pub"

container_image = "mydockerhubuser/python-webapp:latest"

tenant_id       = "00000000-0000-0000-0000-000000000000"

# Your real IP (find via `curl ifconfig.me`)
my_ip_address   = "123.45.67.89"
