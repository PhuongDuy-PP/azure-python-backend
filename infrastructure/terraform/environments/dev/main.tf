terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatec5cded22"
    container_name       = "tfstate"
    key                 = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags     = local.tags
}

# Create App Service resources
module "app_service" {
  source = "../../modules/app_service"

  project_name        = var.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location           = var.location
  sku_name           = "B1"
  tags               = local.tags
}