resource "azurerm_resource_group" "example" {
  name     = "example-RG"
  location = "North Europe"

  # Tags for the Resource Group
  tags = {
    Environment = "Dev"
    Owner       = "kmiszel"
    Source      = "terraform"
  }
}