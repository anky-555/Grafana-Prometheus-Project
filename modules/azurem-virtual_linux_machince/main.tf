resource "azurerm_linux_virtual_machine" "example" {
  for_each            = var.virtual_machine
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  size           = each.value.size
  admin_username = "adminuser"
  admin_password = "Password1234"
  network_interface_ids = [
    data.azurerm_network_interface.nic[each.key].id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_network_interface" "nic" {
  for_each            = var.virtual_machine
  name                = each.value.nicname
  resource_group_name = each.value.resource_group_name
}
