resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "westeurope"
}

module "my_storage_module" {
  source = "./storage-module"
}