module "resource_group_rg1" {
  source              = "./resource_group"
  resource_group_name = var.resource_group_names["rg1"]
  location            = var.location
}

module "vnet_module" {
  source              = "./vnet"
  vnet_name           = "vnet1"
  subnet_name         = "default"
  subnet_id           = module.vnet_module.azurerm_subnet.subnet.id
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.0.0/24"]
  resource_group_name = module.resource_group_rg1.resource_group_name
  resource_group      = module.resource_group_rg1.resource_group
  location            = var.location
}

module "vms" {
  source              = "./vms"
  resource_group_name = module.resource_group_rg1.resource_group_name
  location            = var.location
}