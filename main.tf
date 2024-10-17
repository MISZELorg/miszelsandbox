# resource "azurerm_resource_group" "example" {
#   name     = "example-RG"
#   location = "North Europe"

#   # Tags for the Resource Group
#   tags = {
#     Environment = "Dev"
#     Owner       = "kmiszel"
#     Source      = "terraform"
#   }
# }

resource "azurerm_resource_group" "tf-aks_rg" {
  name     = "tf-aks-rg"
  location = "North Europe"

  tags = {
    Environment = "Dev"
    Owner       = "kmiszel"
    Source      = "terraform"
  }
}

# resource "azurerm_virtual_network" "tf-aks_vnet" {
#   name                = "tf-aks-vnet"
#   location            = azurerm_resource_group.tf-aks_rg.location
#   resource_group_name = azurerm_resource_group.tf-aks_rg.name
#   address_space       = ["10.224.0.0/12"]
# }

# resource "azurerm_subnet" "tf-aks_subnet" {
#   name                 = "tf-aks-subnet"
#   resource_group_name  = azurerm_resource_group.tf-aks_rg.name
#   virtual_network_name = azurerm_virtual_network.tf-aks_vnet.name
#   address_prefixes     = ["10.224.0.0/16"]
# }

# resource "azurerm_network_security_group" "tf-aks_nsg" {
#   name                = "tf-aks-nsg"
#   location            = azurerm_resource_group.tf-aks_rg.location
#   resource_group_name = azurerm_resource_group.tf-aks_rg.name
# }

# resource "azurerm_subnet_network_security_group_association" "tf-aks_nsg_assoc" {
#   subnet_id                 = azurerm_subnet.tf-aks_subnet.id
#   network_security_group_id = azurerm_network_security_group.tf-aks_nsg.id
# }

resource "azurerm_kubernetes_cluster" "tf-aks" {
  name                      = "tf-aks-cluster"
  location                  = azurerm_resource_group.tf-aks_rg.location
  resource_group_name       = azurerm_resource_group.tf-aks_rg.name
  dns_prefix                = "tf-aks-cluster-dns"
  automatic_upgrade_channel = "node-image"
  sku_tier                  = "Free"
  depends_on = [
    azurerm_resource_group.tf-aks_rg
  ]

  default_node_pool {
    name       = "systempool"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "cilium"
    network_data_plane  = "cilium"
    load_balancer_sku   = "standard"
  }

  identity {
    type = "SystemAssigned"
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "tf-aks_agentpool" {
  name                  = "agentpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.tf-aks.id
  vm_size               = "Standard_D2s_v3"
  node_count            = 1
  max_pods              = 110
  mode                  = "User"
  depends_on = [
    azurerm_resource_group.tf-aks_rg,
    azurerm_kubernetes_cluster.tf-aks
  ]
}

# output "client_certificate" {
#   value     = azurerm_kubernetes_cluster.tf-aks.kube_config[0].client_certificate
#   sensitive = true
# }

# output "kube_config" {
#   value     = azurerm_kubernetes_cluster.tf-aks.kube_config_raw
#   sensitive = true
# }


