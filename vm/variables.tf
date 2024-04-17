variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "vmname" {
  type = string
}

variable "vnet_resource_group_name" {
  description = "The name of the resource group where the existing VNet is located"
  type        = string
  default     = ""
}

variable "vnet_name" {
  description = "The name of the existing VNet"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "The name of the existing subnet within the VNet"
  type        = string
  default     = ""
}