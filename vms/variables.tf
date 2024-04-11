variable "location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vm_map" {
  type = map(object({
    name           = string
    admin_password = string
    admin_username = string
    size           = string
  }))
  default = {
    "vm1" = {
      name           = "vm1"
      admin_password = "!@Pa55w0rd123"
      admin_username = "kmiszel"
      size           = "Standard_B1ms"
    }
    "vm2" = {
      name           = "vm2"
      admin_password = "!@Pa55w0rd456"
      admin_username = "kmiszel"
      size           = "Standard_B1ms"
    }
    "vm3" = {
      name           = "vm3"
      admin_password = "!@Pa55w0rd789"
      admin_username = "kmiszel"
      size           = "Standard_B1ms"
    }
  }
}