data "azurerm_virtual_network" "example" {
  name                = "myvet01"
  resource_group_name = "hindirg"
}

output "virtual_network_id" {
  value = data.azurerm_virtual_network.example.id
}



data "azurerm_subnet" "example" {
  name                 = "mysub01"
  virtual_network_name = "myvet01"
  resource_group_name  = "hindirg"
}

output "subnet_id" {
  value = data.azurerm_subnet.example.id
}
data "azurerm_key_vault" "example" {
  name                = "mykv018"
  resource_group_name = "hindirg"
}

data "azurerm_key_vault_secret" "example" {
  name         = "adminusername"
  key_vault_id = data.azurerm_key_vault.example.id
}
data "azurerm_key_vault_secret" "top" {
  name         = "adminpassword"
  key_vault_id = data.azurerm_key_vault.example.id
}