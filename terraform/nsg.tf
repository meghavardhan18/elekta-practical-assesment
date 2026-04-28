resource "azurerm_network_security_group" "elekta-NSG" {
  name                = var.NSG_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.elekta-devops-test
  ]
}

resource "azurerm_subnet_network_security_group_association" "elekta-nsg-subnet-associate" {
  subnet_id                 = azurerm_subnet.elekta-subnet1.id
  network_security_group_id = azurerm_network_security_group.elekta-NSG.id
}