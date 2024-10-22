variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "aks_tags" {
  description = "Common tags to apply to all AKS resources"
  type        = map(string)
}

variable "maintenance_window" {
  description = "Map of maintenance window configuration"
  type        = map(string)
}

variable "default_node_pool" {
  description = "Settings for the default node pool"
  type = object({
    name                          = string
    vm_size                       = string
    auto_scaling_enabled          = bool
    zones                         = list(string)
    node_count                    = number
    min_count                     = number
    max_count                     = number
    max_pods                      = number
    temporary_name_for_rotation   = string
    drain_timeout_in_minutes      = number
    max_surge                     = string
    node_soak_duration_in_minutes = number
  })
}

variable "node_pool_config" {
  description = "Node pool configuration for AKS"
  type = map(object({
    name                 = string
    vm_size              = string
    auto_scaling_enabled = bool
    zones                = list(string)
    node_count           = number
    min_count            = number
    max_count            = number
    max_pods             = number
    mode                 = string
  }))
}

variable "network_profile" {
  description = "Map of settings for the network profile"
  type        = map(string)
}

variable "location" {
  description = "Location of the AKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "grafana_name" {
  description = "Name of the Grafana instance"
  type        = string
}

variable "streams" {
  description = "List of log streams"
  type        = list(string)
}

variable "syslog_facilities" {
  description = "Syslog facilities"
  type        = list(string)
}

variable "syslog_levels" {
  description = "Syslog levels"
  type        = list(string)
}

variable "data_collection_interval" {
  description = "Interval for data collection"
  type        = string
}

variable "namespace_filtering_mode_for_data_collection" {
  description = "Namespace filtering mode for data collection"
  type        = string
}

variable "namespaces_for_data_collection" {
  description = "Namespaces for data collection"
  type        = list(string)
}

variable "enableContainerLogV2" {
  description = "Enable Container Log V2"
  type        = bool
}
