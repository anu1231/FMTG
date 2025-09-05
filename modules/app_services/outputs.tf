output "app_service_url" {
  description = "Default URL of the App Service"
  value       = azurerm_app_service.this.default_site_hostname
}

