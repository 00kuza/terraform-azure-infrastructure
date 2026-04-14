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

resource "azurerm_virtual_network" "main" {
    name = "vnet-${var.project_name}-${var.environment}"
    location = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
    address_space = ["10.0.0.0/16"]
    tags = var.tags

}

resource "azurerm_subnet" "workload" {
    name    = "snet-workload-${var.environment}"
    resource_group_name = azurerm_resource_group.main.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes = ["10.0.1.0/24"]
  
}