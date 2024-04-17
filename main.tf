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