variable "resource_group_names" {
  description = "A map of resource group names to create."
  type        = map(string)
}

variable "location" {
  description = "AZ resource location"
  type        = string
}