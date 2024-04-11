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
