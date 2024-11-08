tenant_id    = "48c383d8-47c5-48f9-9e8b-afe4f2519054"
location     = "northeurope"
cluster_name = "pubaks"
# # grafana_name = "miszelegrafana"

aks_tags = {
  Environment = "Dev"
  Owner       = "kmiszel"
  Source      = "terraform"
  #   Git         = "github"
  #   Purpose     = "AKS"
}

maintenance_window = {
  frequency   = "Weekly"
  duration    = "4"
  interval    = "1"
  day_of_week = "Sunday"
  start_time  = "00:00"
  start_date  = "2024-10-22T00:00:00Z"
  utc_offset  = "+00:00"
}

default_node_pool = {
  name                 = "agent"
  vm_size              = "Standard_D2s_v3"
  auto_scaling_enabled = false
  #   zones                         = ["1", "2", "3"]
  node_count                    = 1
  min_count                     = null
  max_count                     = null
  max_pods                      = 110
  temporary_name_for_rotation   = "agenttemp"
  drain_timeout_in_minutes      = 0
  max_surge                     = "10%"
  node_soak_duration_in_minutes = 0
}

network_profile = {
  network_plugin      = "azure"
  network_plugin_mode = "overlay"
  network_policy      = "cilium"
  network_data_plane  = "cilium"
  load_balancer_sku   = "standard"
}

# node_pool_config = {
#   user = {
#     name                 = "user"
#     vm_size              = "Standard_D2s_v3"
#     auto_scaling_enabled = true
#     zones                = ["1", "2", "3"]
#     node_count           = 1
#     min_count            = 1
#     max_count            = 2
#     max_pods             = 110
#     mode                 = "User"
#   }
# }

# streams = [
#   "Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents",
#   "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory",
#   "Microsoft-KubePVInventory", "Microsoft-KubeServices",
#   "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics",
#   "Microsoft-ContainerInventory", "Microsoft-ContainerNodeInventory", "Microsoft-Perf"
# ]

# syslog_facilities = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "local0", "local1", "local2", "local3", "local4", "local5", "local6", "local7", "lpr", "mail", "news", "syslog", "user", "uucp"]

# syslog_levels = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]

# data_collection_interval = "1m"

# namespace_filtering_mode_for_data_collection = "Off"

# namespaces_for_data_collection = ["kube-system", "gatekeeper-system", "azure-arc"]

# enableContainerLogV2 = true
