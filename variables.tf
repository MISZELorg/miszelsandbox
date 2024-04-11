# variable "location" {}
# variable "resource_group_name" {}
variable "rg_map" {
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    "rg1" = {
      name     = "rg1"
      location = "westeurope"
    }
    "rg2" = {
      name     = "rg2"
      location = "northeurope"
    }
    "rg3" = {
      name     = "rg3"
      location = "polandcentral"
    }
  }
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
