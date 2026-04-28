resource "azurerm_public_ip" "elekta-public-ip" {
  count               = 2
  name                = "${var.public_ip_name_prefix}-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"

  depends_on = [
    azurerm_resource_group.elekta-devops-test
  ]
}

resource "azurerm_network_interface" "elekta-nic" {
  count               = 2
  name                = "${var.nic_name_prefix}-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.elekta-subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.elekta-public-ip[count.index].id
  }
}

resource "azurerm_windows_virtual_machine" "elekta-VM1" {
  count               = 2
  name                = "${var.vm_name_prefix}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B2ats_v2"
  admin_username      = var.user_name
  admin_password      = var.password

  network_interface_ids = [
    azurerm_network_interface.elekta-nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}