module "resource_group_rg1" {
  source              = "./rg"
  resource_group_name = var.resource_group_names["rg1"]
  location            = var.location
}

module "storage_account_sa1" {
  source              = "./sa"
  sa_name             = var.sa_name
  resource_group_name = var.resource_group_names["rg1"]
  location            = var.location
}

module "resource_group_rg2" {
  source              = "./rg"
  resource_group_name = var.resource_group_names["rg2"]
  location            = var.location
}

module "storage_account_sa2" {
  source              = "./sa"
  sa_name             = var.sa_name2
  resource_group_name = var.resource_group_names["rg2"]
  location            = var.location
  depends_on          = [module.resource_group_rg2]
}

module "vnet_module" {
  source              = "./vnet"
  vnet_name           = var.vnet_name
  subnet_name         = var.subnet_name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.0.0/24"]
  resource_group_name = module.resource_group_rg1.resource_group_name
  location            = var.location
}

module "vm_module" {
  source              = "./vm"
  resource_group_name = module.resource_group_rg1.resource_group_name
  location            = var.location
  vmname              = var.vmname
}