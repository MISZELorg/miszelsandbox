variable "tenant_id" {
  default = "48c383d8-47c5-48f9-9e8b-afe4f2519054"
}

# variable "aks_tags" {
#   description = "Common tags to apply to all AKS resources"
#   type        = map(string)
#   default = {
#     Environment = "Dev"
#     Owner       = "kmiszel"
#     Source      = "terraform"
#     Git         = "github"
#     Purpose     = "AKS"
#   }
# }

# variable "maintenance_window" {
#   description = "Map of maintenance window configuration"
#   type        = map(string)
#   default = {
#     frequency   = "Weekly"
#     duration    = "4"
#     interval    = "1"
#     day_of_week = "Sunday"
#     start_time  = "00:00"
#     start_date  = "2024-10-22T00:00:00Z"
#     utc_offset  = "+00:00"
#   }
# }

# variable "default_node_pool" {
#   description = "Settings for the default node pool"
#   type = object({
#     name                          = string
#     vm_size                       = string
#     auto_scaling_enabled          = bool
#     zones                         = list(string)
#     node_count                    = number
#     min_count                     = number
#     max_count                     = number
#     max_pods                      = number
#     temporary_name_for_rotation   = string
#     drain_timeout_in_minutes      = number
#     max_surge                     = string
#     node_soak_duration_in_minutes = number
#   })
#   default = {
#     name                          = "agent"
#     vm_size                       = "Standard_D2s_v3"
#     auto_scaling_enabled          = true
#     zones                         = ["1", "2", "3"]
#     node_count                    = 2
#     min_count                     = 2
#     max_count                     = 3
#     max_pods                      = 110
#     temporary_name_for_rotation   = "agenttemp"
#     drain_timeout_in_minutes      = 0
#     max_surge                     = "10%"
#     node_soak_duration_in_minutes = 0
#   }
# }

# variable "node_pool_config" {
#   description = "Node pool configuration for AKS"
#   type = map(object({
#     name                 = string
#     vm_size              = string
#     auto_scaling_enabled = bool
#     zones                = list(string)
#     node_count           = number
#     min_count            = number
#     max_count            = number
#     max_pods             = number
#     mode                 = string
#   }))
#   default = {
#     user = {
#       name                 = "user"
#       vm_size              = "Standard_D2s_v3"
#       auto_scaling_enabled = true
#       zones                = ["1", "2", "3"]
#       node_count           = 1
#       min_count            = 1
#       max_count            = 2
#       max_pods             = 110
#       mode                 = "User"
#     }
#   }
# }

# variable "network_profile" {
#   description = "Map of settings for the network profile"
#   type        = map(string)
#   default = {
#     network_plugin      = "azure"
#     network_plugin_mode = "overlay"
#     network_policy      = "cilium"
#     network_data_plane  = "cilium"
#     load_balancer_sku   = "standard"
#   }
# }

# variable "location" {
#   default = "northeurope"
# }

# variable "cluster_name" {
#   default = "akscluster"
# }

# variable "grafana_name" {
#   default = "miszelegrafana"
# }

# variable "streams" {
#   default = ["Microsoft-ContainerLog", "Microsoft-ContainerLogV2", "Microsoft-KubeEvents", "Microsoft-KubePodInventory", "Microsoft-KubeNodeInventory", "Microsoft-KubePVInventory", "Microsoft-KubeServices", "Microsoft-KubeMonAgentEvents", "Microsoft-InsightsMetrics", "Microsoft-ContainerInventory", "Microsoft-ContainerNodeInventory", "Microsoft-Perf"]
# }

# variable "syslog_facilities" {
#   type    = list(string)
#   default = ["auth", "authpriv", "cron", "daemon", "mark", "kern", "local0", "local1", "local2", "local3", "local4", "local5", "local6", "local7", "lpr", "mail", "news", "syslog", "user", "uucp"]
# }

# variable "syslog_levels" {
#   type    = list(string)
#   default = ["Debug", "Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
# }

# variable "data_collection_interval" {
#   default = "1m"
# }

# variable "namespace_filtering_mode_for_data_collection" {
#   default = "Off"
# }

# variable "namespaces_for_data_collection" {
#   default = ["kube-system", "gatekeeper-system", "azure-arc"]
# }

# variable "enableContainerLogV2" {
#   default = true
# }

