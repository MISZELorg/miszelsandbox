resource "azurerm_resource_group" "aks-monitoring_rg" {
  name     = "${var.cluster_name}-${var.location}-monitoring-rg"
  location = var.location
  tags     = var.aks_tags
}

resource "azurerm_log_analytics_workspace" "aks_laws" {
  name                = "aksmonitoring"
  location            = azurerm_resource_group.aks-monitoring_rg.location
  resource_group_name = azurerm_resource_group.aks-monitoring_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks-monitoring_rg
  ]
}

resource "azurerm_monitor_workspace" "aks_amw" {
  name                = "aksamw"
  location            = azurerm_resource_group.aks-monitoring_rg.location
  resource_group_name = azurerm_resource_group.aks-monitoring_rg.name
  tags                = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks-monitoring_rg
  ]
}

resource "azurerm_dashboard_grafana" "aks_grafana" {
  name                              = var.grafana_name
  resource_group_name               = azurerm_resource_group.aks-monitoring_rg.name
  location                          = azurerm_resource_group.aks-monitoring_rg.location
  grafana_major_version             = 10
  api_key_enabled                   = false
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true
  tags                              = var.aks_tags
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.aks_amw.id
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_monitor_workspace.aks_amw
  ]
}

resource "azurerm_monitor_data_collection_endpoint" "aks_dce" {
  name                = "aksdce"
  resource_group_name = azurerm_resource_group.aks-monitoring_rg.name
  location            = azurerm_resource_group.aks-monitoring_rg.location
  kind                = "Linux"
}

resource "azurerm_monitor_data_collection_rule" "aks_promdcr" {
  name                        = "MSProm-${azurerm_resource_group.aks-monitoring_rg.location}-${var.cluster_name}"
  resource_group_name         = azurerm_resource_group.aks-monitoring_rg.name
  location                    = azurerm_resource_group.aks-monitoring_rg.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.aks_dce.id
  tags                        = var.aks_tags
  depends_on = [
    azurerm_monitor_data_collection_endpoint.aks_dce,
    azurerm_monitor_workspace.aks_amw
  ]

  destinations {
    monitor_account {
      monitor_account_id = azurerm_monitor_workspace.aks_amw.id
      name               = "MonitoringAccount1"
    }
  }

  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = ["MonitoringAccount1"]
  }

  data_sources {
    prometheus_forwarder {
      streams = ["Microsoft-PrometheusMetrics"]
      name    = "PrometheusDataSource"
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "aks_amwdcra" {
  name                    = "MSProm-${azurerm_resource_group.aks-monitoring_rg.location}-${var.cluster_name}"
  target_resource_id      = azurerm_kubernetes_cluster.aks_cluster.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.aks_promdcr.id
  depends_on = [
    azurerm_monitor_data_collection_rule.aks_promdcr,
    azurerm_kubernetes_cluster.aks_cluster
  ]
}

resource "azurerm_monitor_data_collection_rule" "aks_cidcr" {
  name                = "MSCI-${azurerm_resource_group.aks-monitoring_rg.location}-${var.cluster_name}"
  resource_group_name = azurerm_resource_group.aks-monitoring_rg.name
  location            = azurerm_resource_group.aks-monitoring_rg.location
  tags                = var.aks_tags
  depends_on = [
    azurerm_resource_group.aks_rg,
    azurerm_kubernetes_cluster.aks_cluster
  ]

  destinations {
    log_analytics {
      workspace_resource_id = azurerm_log_analytics_workspace.aks_laws.id
      name                  = "ciworkspace"
    }
  }

  data_flow {
    streams      = var.streams
    destinations = ["ciworkspace"]
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["ciworkspace"]
  }

  data_sources {
    syslog {
      streams        = ["Microsoft-Syslog"]
      facility_names = var.syslog_facilities
      log_levels     = var.syslog_levels
      name           = "sysLogsDataSource"
    }

    extension {
      streams        = var.streams
      extension_name = "ContainerInsights"
      extension_json = jsonencode({
        "dataCollectionSettings" : {
          "interval" : var.data_collection_interval,
          "namespaceFilteringMode" : var.namespace_filtering_mode_for_data_collection,
          "namespaces" : var.namespaces_for_data_collection
          "enableContainerLogV2" : var.enableContainerLogV2
        }
      })
      name = "ContainerInsightsExtension"
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "aks_cidcra" {
  name                    = "ContainerInsightsExtension"
  target_resource_id      = azurerm_kubernetes_cluster.aks_cluster.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.aks_cidcr.id
  depends_on = [
    azurerm_monitor_data_collection_rule.aks_cidcr
  ]

}