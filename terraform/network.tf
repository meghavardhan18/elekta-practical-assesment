resource "azurerm_virtual_network" "elekta-VNet" {
  name                = var.VNET_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  depends_on = [
    azurerm_resource_group.elekta-devops-test
  ]
}

resource "azurerm_subnet" "elekta-subnet1" {
  name                 = var.Subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.VNET_name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [
    azurerm_virtual_network.elekta-VNet
  ]
}