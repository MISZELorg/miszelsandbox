variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "vnet_name" {
  description = "The name of the VNET."
  type        = string
}

variable "address_space" {
  description = "The address space for the VNET."
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_prefixes" {
  description = "The address prefixes for the subnet."
  type        = list(string)
}