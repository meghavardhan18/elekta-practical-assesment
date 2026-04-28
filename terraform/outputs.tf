output "VM_Test_1" {
  value = {
    resource_group_name = azurerm_resource_group.elekta-devops-test.name
    vm_name             = azurerm_windows_virtual_machine.elekta-VM1[0].name
    public_ip           = azurerm_public_ip.elekta-public-ip[0].ip_address
    private_ip          = azurerm_network_interface.elekta-nic[0].private_ip_address
  }
}

output "VM_Test_2" {
  value = {
    resource_group_name = azurerm_resource_group.elekta-devops-test.name
    vm_name             = azurerm_windows_virtual_machine.elekta-VM1[1].name
    public_ip           = azurerm_public_ip.elekta-public-ip[1].ip_address
    private_ip          = azurerm_network_interface.elekta-nic[1].private_ip_address
  }
}