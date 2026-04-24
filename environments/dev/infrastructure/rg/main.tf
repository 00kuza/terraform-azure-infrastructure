
# State which provider plug-in to use and pin version.
terraform {
    required_version = ">=1.5.0"
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.0"
        }
    }
}

# Mandatory field specifically for Azure. It can be used to customise resource behaviours during certain events 
# like deletion. 
provider "azurerm" {
    features {}
}

# This is what deploys - resource group.
resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.location
    tags     = var.tags
}

    