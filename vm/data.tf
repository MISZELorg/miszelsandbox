data "azurerm_subnet" "existing_subnet" {
  name                 = module.vnet_module.subnet_name
  virtual_network_name = module.vnet_module.vnet_name
  resource_group_name  = module.resource_group_rg1.resource_group_name
}