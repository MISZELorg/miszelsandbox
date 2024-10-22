# resource "azurerm_role_assignment" "aks_readerrole" {
#   scope              = azurerm_monitor_workspace.aks_amw.id
#   role_definition_id = "/subscriptions/${data.azurerm_client_config.aks_subscription.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/b0d8363b-8ddd-447d-831f-62ca05bff136"
#   principal_id       = azurerm_dashboard_grafana.aks_grafana.identity.0.principal_id
#   depends_on = [
#     azurerm_monitor_workspace.aks_amw,
#     azurerm_dashboard_grafana.aks_grafana
#   ]
# }

# resource "azurerm_role_assignment" "aks-acr_assign" {
#   principal_id                     = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.aks-acr_acr.id
#   skip_service_principal_aad_check = false
#   depends_on = [
#     azurerm_container_registry.aks-acr_acr
#   ]
# }

# resource "azurerm_role_assignment" "aks_grafanaviewer" {
#   scope              = azurerm_dashboard_grafana.aks_grafana.id
#   role_definition_id = "/subscriptions/${data.azurerm_client_config.aks_subscription.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/60921a7e-fef1-4a43-9b16-a26c52ad4769"
#   principal_id       = data.azuread_group.k8s_admins.object_id
#   depends_on = [
#     azurerm_dashboard_grafana.aks_grafana
#   ]
# }