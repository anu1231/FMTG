resource "azurerm_app_service_plan" "this" {
name = var.plan_name
resource_group_name = var.resource_group_name
location = var.location
kind = "Linux"
reserved = true
sku {
tier = var.sku_tier
size = var.sku_size
}
}


resource "azurerm_container_registry" "acr" {
name = var.acr_name
resource_group_name = var.resource_group_name
location = var.location
sku = "Basic"
admin_enabled = true
}


resource "azurerm_app_service" "this" {
name = var.app_name
resource_group_name = var.resource_group_name
location = var.location
app_service_plan_id = azurerm_app_service_plan.this.id


site_config {
linux_fx_version = "DOCKER|${var.container_image}"
always_on = true
app_command_line = var.start_command
}


app_settings = merge({
"WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
"DOCKER_REGISTRY_SERVER_URL" = "https://${azurerm_container_registry.acr.login_server}"
"DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
"DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
}, var.extra_app_settings)


identity {
type = "SystemAssigned"
}
}