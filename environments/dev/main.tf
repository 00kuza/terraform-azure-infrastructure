terraform {
  required_version = ">= 1.5.0"

required_providers {
  azurerm = {
    source = "hashicorp/azurerm"
    version = "~> 3.0"
    }
  }
}

provider "azurerm" {
    features{} 
}

resource "azurerm_resource_group" "main" {
    name    = "rg-${var.project_name}-${var.environment}"
    location = var.location
    tags = var.tags 
}

