terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.8.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-githubtfstates"
    storage_account_name = "miszelsandbox"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    subscription_id      = "f80611eb-0851-4373-b7a3-f272906843c4"
    tenant_id            = "48c383d8-47c5-48f9-9e8b-afe4f2519054"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

###

# resource "azurerm_resource_group" "rg1" {
#   name     = "rg1"
#   location = "westeurope"
# }

# resource "azurerm_resource_group" "rg2" {
#   name     = "rg2"
#   location = "northeurope"
# }

# resource "azurerm_resource_group" "rg3" {
#   name     = "rg3"
#   location = "polandcentral"
# }

###

resource "azurerm_resource_group" "rg-res" {
  for_each = var.rg_map
  name     = each.value.name
  location = each.value.location
}

##################################################

resource "azurerm_resource_group" "rg-test" {
  location = "northeurope"
  name     = "rgtest2"
}

resource "azurerm_virtual_network" "vnet-test" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-test.location
  name                = "vnet-test"
  resource_group_name = azurerm_resource_group.rg-test.name
}
resource "azurerm_subnet" "subnet-test" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = azurerm_resource_group.rg-test.name
  virtual_network_name = azurerm_virtual_network.vnet-test.name
  depends_on = [
    azurerm_virtual_network.vnet-test,
  ]
}

resource "azurerm_public_ip" "pip-test" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg-test.location
  name                = "vmtest-ip"
  resource_group_name = azurerm_resource_group.rg-test.name
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "nsg-test" {
  location            = azurerm_resource_group.rg-test.location
  name                = "vmtest-nsg"
  resource_group_name = azurerm_resource_group.rg-test.name
}

resource "azurerm_network_interface" "vmnic-test" {
  location            = azurerm_resource_group.rg-test.location
  name                = "vmtestnic1"
  resource_group_name = azurerm_resource_group.rg-test.name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip-test.id
    subnet_id                     = azurerm_subnet.subnet-test.id
  }
  depends_on = [
    azurerm_public_ip.pip-test,
    azurerm_subnet.subnet-test,
  ]
}

resource "azurerm_linux_virtual_machine" "vm-test" {
  admin_password                  = "!@Pa55w0rd123"
  admin_username                  = "kmiszel"
  disable_password_authentication = false
  location                        = azurerm_resource_group.rg-test.location
  name                            = "vmtest"
  network_interface_ids           = [azurerm_network_interface.vmnic-test.id]
  resource_group_name             = azurerm_resource_group.rg-test.name
  secure_boot_enabled             = true
  size                            = "Standard_B1ms"
  vtpm_enabled                    = true
  additional_capabilities {
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-focal"
    publisher = "canonical"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.vmnic-test,
  ]
}


# resource "azurerm_network_interface_security_group_association" "res-3" {
#   network_interface_id      = "/subscriptions/456fb512-af18-4d07-861c-3ee54eae9181/resourceGroups/rgtest/providers/Microsoft.Network/networkInterfaces/vmtest965"
#   network_security_group_id = "/subscriptions/456fb512-af18-4d07-861c-3ee54eae9181/resourceGroups/rgtest/providers/Microsoft.Network/networkSecurityGroups/vmtest-nsg"
#   depends_on = [
#     azurerm_network_interface.res-2,
#     azurerm_network_security_group.res-4,
#   ]
# }




