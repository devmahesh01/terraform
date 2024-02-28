



resource "azurerm_network_interface" "main" {
  for_each            = var.vm
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     =  data.azurerm_subnet.example.id


    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  for_each              = var.vm
  name                  = each.key
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [azurerm_network_interface.main[each.key].id]
  vm_size               = "Standard_DS1_v2"
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = data.azurerm_key_vault_secret.example.value
    admin_password = data.azurerm_key_vault_secret.top.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}