output "app_service_name" {
  description = "The name of the App Service"
  value       = azurerm_linux_web_app.app.name
}

output "app_service_url" {
  description = "The URL of the App Service"
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
}
