resource "azurerm_network_interface" "vmnic-test" {
  location            = var.location
  name                = "${var.vmname}-nic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "${var.vmname[count.index]}-ipconfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
  }
  depends_on = [
    module.vnet_module.azurerm_subnet.subnet,
  ]
}

# resource "azurerm_linux_virtual_machine" "vm-test" {
#   admin_password                  = "!@Pa55w0rd123"
#   admin_username                  = "kmiszel"
#   disable_password_authentication = false
#   location                        = azurerm_resource_group.rg-test.location
#   name                            = "vmtest"
#   network_interface_ids           = [azurerm_network_interface.vmnic-test.id]
#   resource_group_name             = azurerm_resource_group.rg-test.name
#   secure_boot_enabled             = true
#   size                            = "Standard_B1ms"
#   vtpm_enabled                    = true
#   additional_capabilities {
#   }
#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     offer     = "0001-com-ubuntu-server-focal"
#     publisher = "canonical"
#     sku       = "20_04-lts-gen2"
#     version   = "latest"
#   }
#   depends_on = [
#     azurerm_network_interface.vmnic-test,
#   ]
# }
