terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

backend "azurerm" {
  resource_group_name = "rg-tfstate-planetary-app"
  storage_account_name = "stplanetsgj"
  container_name = "tfstate"
}

resource "azurerm_resource_group" "backend_rg" {
  name     = "rg-tfstate-planetary-app"
  location = "swedencentral"
}

resource "azurerm_storage_account" "backend_state" {
  name                     = "stplanetsgj"
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.backend_state.name
  container_access_type = "private"
}