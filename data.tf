data "azurerm_client_config" "aks_subscription" {}

data "azuread_group" "k8s_admins" {
  display_name = "k8s_admins"
}