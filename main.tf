terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.8.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-githubtfstates"
    storage_account_name = "miszelsandbox"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    subscription_id      = "f80611eb-0851-4373-b7a3-f272906843c4"
    tenant_id            = "48c383d8-47c5-48f9-9e8b-afe4f2519054"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

###

# resource "azurerm_resource_group" "rg1" {
#   name     = "rg1"
#   location = "westeurope"
# }

# resource "azurerm_resource_group" "rg2" {
#   name     = "rg2"
#   location = "northeurope"
# }

# resource "azurerm_resource_group" "rg3" {
#   name     = "rg3"
#   location = "polandcentral"
# }

###

resource "azurerm_resource_group" "rg-res" {
  for_each = var.rg_map
  name     = each.value.name
  location = each.value.location
}

