terraform {
  backend "azurerm" {
    storage_account_name = "ggst0101"
    resource_group_name  = "test-RG"
    container_name       = "backend"
    key                  = "github-backend.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.1"
    }
  }
}

provider "azurerm" {
  features {

  }
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg-name
  location = var.location
  tags = {
    "owner" = var.owner
  }
}

resource "azurerm_managed_disk" "disk" {
  name                 = var.disk-name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  create_option        = "Empty"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = var.disk-size
}
