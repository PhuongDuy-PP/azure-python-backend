resource "azurerm_service_plan" "app_plan" {
  name                = "${var.project_name}-${var.environment}-plan"
  resource_group_name = var.resource_group_name
  location           = var.location
  os_type            = "Linux"
  sku_name           = var.sku_name
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.project_name}-${var.environment}-app"
  resource_group_name = var.resource_group_name
  location           = var.location
  service_plan_id    = azurerm_service_plan.app_plan.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "WEBSITE_PORT"                   = "8000"
    "ENVIRONMENT"                    = var.environment
  }

  tags = var.tags
}
