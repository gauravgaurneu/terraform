terraform {
    backend "azurerm" {
      storage_account_name = "ggst0101"
      resource_group_name = "test-RG"
      container_name = "backend"
      key = "github-backend.tfstate"
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
  subscription_id = "e1789001-12cb-4ff3-8522-59a2dafc5dca"
}

resource "azurerm_resource_group" "rg" {
  name     = "gg-rg"
  location = "centralindia"
  tags = {
    "owner" = "gaurav.gaur@neudesic.com"
  }
}

resource "azurerm_managed_disk" "disk" {
  name                 = "gg-disk1"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  create_option        = "Empty"
  storage_account_type = "Standard_LRS"
  disk_size_gb         = 256
}
