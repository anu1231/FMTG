resource "azurerm_app_service_plan" "this" {
  name                = var.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "this" {
  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  app_service_plan_id = azurerm_app_service_plan.this.id

  site_config {
    linux_fx_version = "DOCKER|${var.container_image}"
    # always_on = true  # ❌ not supported on Free tier
    app_command_line = var.start_command
  }

  app_settings = var.extra_app_settings

  identity {
    type = "SystemAssigned"
  }
}
