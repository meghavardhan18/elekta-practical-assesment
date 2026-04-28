resource "azurerm_resource_group" "elekta-devops-test" {
  name     = var.resource_group_name
  location = var.location
}