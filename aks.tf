resource "azurerm_resource_group" "aks_rg" {
  name     = "${var.cluster_name}-${var.location}-aks-rg"
  location = var.location
  tags     = var.aks_tags
  depends_on = [
    azurerm_log_analytics_workspace.aks_laws,
    azurerm_dashboard_grafana.aks_grafana,
    azurerm_resource_group.aks-network_rg
  ]
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                         = var.cluster_name
  location                     = azurerm_resource_group.aks_rg.location
  resource_group_name          = azurerm_resource_group.aks_rg.name
  node_resource_group          = "${var.cluster_name}-${var.location}-node-rg"
  dns_prefix                   = "${var.cluster_name}-dns"
  automatic_upgrade_channel    = "patch"
  sku_tier                     = "Free"
  local_account_disabled       = true
  image_cleaner_enabled        = true
  azure_policy_enabled         = true
  image_cleaner_interval_hours = 168
  tags                         = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks_rg
  ]

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "10m"
  }

  oms_agent {
    log_analytics_workspace_id      = azurerm_log_analytics_workspace.aks_laws.id
    msi_auth_for_monitoring_enabled = true
  }

  monitor_metrics {
    annotations_allowed = null
    labels_allowed      = null
  }

  maintenance_window_auto_upgrade {
    frequency   = var.maintenance_window["frequency"]
    duration    = tonumber(var.maintenance_window["duration"])
    interval    = tonumber(var.maintenance_window["interval"])
    day_of_week = var.maintenance_window["day_of_week"]
    start_time  = var.maintenance_window["start_time"]
    start_date  = var.maintenance_window["start_date"]
    utc_offset  = var.maintenance_window["utc_offset"]
  }

  maintenance_window_node_os {
    frequency   = var.maintenance_window["frequency"]
    duration    = tonumber(var.maintenance_window["duration"])
    interval    = tonumber(var.maintenance_window["interval"])
    day_of_week = var.maintenance_window["day_of_week"]
    start_time  = var.maintenance_window["start_time"]
    start_date  = var.maintenance_window["start_date"]
    utc_offset  = var.maintenance_window["utc_offset"]
  }

  default_node_pool {
    name                        = var.default_node_pool.name
    vm_size                     = var.default_node_pool.vm_size
    vnet_subnet_id              = azurerm_subnet.aks_subnet.id
    auto_scaling_enabled        = var.default_node_pool.auto_scaling_enabled
    zones                       = var.default_node_pool.zones
    node_count                  = var.default_node_pool.node_count
    min_count                   = var.default_node_pool.min_count
    max_count                   = var.default_node_pool.max_count
    max_pods                    = var.default_node_pool.max_pods
    temporary_name_for_rotation = var.default_node_pool.temporary_name_for_rotation

    upgrade_settings {
      drain_timeout_in_minutes      = var.default_node_pool.drain_timeout_in_minutes
      max_surge                     = var.default_node_pool.max_surge
      node_soak_duration_in_minutes = var.default_node_pool.node_soak_duration_in_minutes
    }
  }

  network_profile {
    network_plugin      = var.network_profile["network_plugin"]
    network_plugin_mode = var.network_profile["network_plugin_mode"]
    network_policy      = var.network_profile["network_policy"]
    network_data_plane  = var.network_profile["network_data_plane"]
    load_balancer_sku   = var.network_profile["load_balancer_sku"]
  }

  identity {
    type = "SystemAssigned"
  }

  #   azure_active_directory_role_based_access_control {
  #     azure_rbac_enabled = true
  #     admin_group_object_ids = [
  #       data.azuread_group.k8s_admins.object_id
  #     ]
  #   }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_cluster_userpool" {
  for_each              = var.node_pool_config
  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = each.value.vm_size
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  auto_scaling_enabled  = each.value.auto_scaling_enabled
  zones                 = each.value.zones
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  max_pods              = each.value.max_pods
  mode                  = each.value.mode
  tags                  = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks_rg,
    azurerm_kubernetes_cluster.aks_cluster
  ]
}