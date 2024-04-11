resource "azurerm_network_interface" "vmnic-test" {
  for_each            = var.vm_map
  location            = var.location
  name                = "${each.value.name}-nic"
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = module.vnet_module.azurerm_virtual_network.vnet.id
  }
  depends_on = [
    module.vnet_module.azurerm_subnet.subnet,
  ]
}
resource "azurerm_linux_virtual_machine" "vm-test" {
  for_each                        = var.vm_map
  admin_password                  = each.value.admin_password
  admin_username                  = each.value.admin_username
  disable_password_authentication = false
  location                        = var.location
  name                            = each.value.name
  network_interface_ids           = [azurerm_network_interface.vmnic-test[each.key].id]
  resource_group_name             = module.resource_group_rg1.resource_group_name
  secure_boot_enabled             = true
  size                            = each.value.size
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