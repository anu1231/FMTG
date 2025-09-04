resource "azurerm_network_interface" "this" {
name = "nic-${var.name}"
location = var.location
resource_group_name = var.resource_group_name


ip_configuration {
name = "internal"
subnet_id = var.subnet_id
private_ip_address_allocation = "Dynamic"
public_ip_address_id = var.public_ip_id
}
}


resource "azurerm_linux_virtual_machine" "this" {
name = var.name
resource_group_name = var.resource_group_name
location = var.location
size = var.vm_size
admin_username = var.admin_username
network_interface_ids = [azurerm_network_interface.this.id]


admin_ssh_key {
username = var.admin_username
public_key = var.ssh_public_key
}


os_disk {
caching = "ReadWrite"
storage_account_type = var.os_disk_type
}


source_image_reference {
publisher = var.image_publisher
offer = var.image_offer
sku = var.image_sku
version = "latest"
}


custom_data = var.custom_data
tags = var.tags
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allowed_ssh_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RabbitMQ-Management"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "15672"
    source_address_prefix      = var.allowed_ssh_ip
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}
