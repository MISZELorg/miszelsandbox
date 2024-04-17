resource "azurerm_resource_group" "rg1" {
  name     = "rg1"
  location = "westeurope"
}

# resource "azurerm_storage_account" "example" {
#   name                     = "kmiszelstrg187"
#   resource_group_name      = azurerm_resource_group.rg1.name
#   location                 = azurerm_resource_group.rg1.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   depends_on = [ azurerm_resource_group.rg1 ]
# }