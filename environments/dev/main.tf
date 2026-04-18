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

# Get current Azure client info (needed for Key Vault access)
data "azurerm_client_config" "current" {}

# Key Vault for storing secrets
resource "azurerm_key_vault" "main" {
  name = "kv-${var.project_name}-${var.environment}"
  location = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name = "standard"

  # Security settings - prevents permanent deletion
  purge_protection_enabled = false  # Set true in prod
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge"
    ]
  }

  tags = var.tags

}

  