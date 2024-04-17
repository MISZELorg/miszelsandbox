module "resource_group_rg1" {
  source = "./resource_group"

  resource_group_name = var.resource_group_names["rg1"]
  location            = var.location
}