resource "azurerm_resource_group" "aks-acr_rg" {
  name     = "${var.cluster_name}-${var.location}-acr-rg"
  location = var.location
  tags     = var.aks_tags
  depends_on = [
    azurerm_kubernetes_cluster.aks_cluster
  ]
}

resource "azurerm_container_registry" "aks-acr_acr" {
  name                = "${var.cluster_name}${var.location}acr"
  resource_group_name = azurerm_resource_group.aks-acr_rg.name
  location            = azurerm_resource_group.aks-acr_rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks-acr_rg
  ]
}