# resource "azurerm_role_assignment" "aks-acr_assign" {
#   principal_id                     = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.aks-acr_acr.id
#   skip_service_principal_aad_check = false
#   depends_on = [
#     azurerm_container_registry.aks-acr_acr
#   ]
# }