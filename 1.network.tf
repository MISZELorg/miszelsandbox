resource "azurerm_resource_group" "aks-network_rg" {
  name     = "${var.cluster_name}-${var.location}-network-rg"
  location = var.location
  tags     = var.aks_tags
}

resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.cluster_name}-${var.location}-vnet"
  location            = azurerm_resource_group.aks-network_rg.location
  resource_group_name = azurerm_resource_group.aks-network_rg.name
  address_space       = ["10.224.0.0/12"]
  tags                = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks-network_rg
  ]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.cluster_name}-${var.location}-subnet"
  resource_group_name  = azurerm_resource_group.aks-network_rg.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.224.0.0/16"]
  depends_on = [
    azurerm_virtual_network.aks_vnet
  ]
}