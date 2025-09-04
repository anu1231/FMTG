resource "azurerm_virtual_network" "this" {
name = var.vnet_name
resource_group_name = var.resource_group_name
location = var.location
address_space = [var.address_space]
}


resource "azurerm_subnet" "apps" {
name = var.subnet_name
resource_group_name = var.resource_group_name
virtual_network_name = azurerm_virtual_network.this.name
address_prefixes = [var.subnet_prefix]
}


resource "azurerm_network_security_group" "this" {
name = var.nsg_name
resource_group_name = var.resource_group_name
location = var.location


dynamic "security_rule" {
for_each = var.security_rules
content {
name = security_rule.value.name
priority = security_rule.value.priority
direction = security_rule.value.direction
access = security_rule.value.access
protocol = security_rule.value.protocol
source_port_range = security_rule.value.source_port_range
destination_port_range = security_rule.value.destination_port_range
source_address_prefix = security_rule.value.source_address_prefix
destination_address_prefix = security_rule.value.destination_address_prefix
}
}
}


resource "azurerm_subnet_network_security_group_association" "assoc" {
subnet_id = azurerm_subnet.apps.id
network_security_group_id = azurerm_network_security_group.this.id
}