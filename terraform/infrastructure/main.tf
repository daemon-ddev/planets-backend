terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-planetary-app"
    storage_account_name = "stplanetsgj"
    container_name       = "tfstate"
    key                  = "infrastructure.tfstate"
  }
}

provider "azurerm" {
  features {}
}
