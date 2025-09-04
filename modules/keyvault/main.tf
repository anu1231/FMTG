resource "azurerm_key_vault" "this" {
name = var.name
location = var.location
resource_group_name = var.resource_group_name
tenant_id = data.azurerm_client_config.current.tenant_id
sku_name = "standard"
purge_protection_enabled = false
soft_delete_enabled = true


access_policy {
tenant_id = data.azurerm_client_config.current.tenant_id
object_id = data.azurerm_client_config.current.object_id


secret_permissions = ["get", "set", "delete", "list"]
}
}