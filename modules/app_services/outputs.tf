output "app_service_url" {
  description = "Default URL of the App Service"
  value       = azurerm_linux_web_app.this.default_hostname
}
