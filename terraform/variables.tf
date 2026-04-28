variable "resource_group_name" {
  type        = string
  description = "name of the resource_group"
}
variable "location" {
  type        = string
  description = "name of the location of this rg"
}
variable "VNET_name" {
  type        = string
  description = "name of the VNET"
}
variable "Subnet_name" {
  type        = string
  description = "name of the Subnet"
}
variable "NSG_name" {
  type        = string
  description = "name of the NSG"
}
variable "public_ip_name_prefix" {
  type        = string
  description = "prefix name of the public_ip"
}
variable "nic_name_prefix" {
  type        = string
  description = "prefix name of the nic"
}
variable "vm_name_prefix" {
  type        = string
  description = "prefix name of the vm"
}
variable "user_name" {
  type        = string
  description = "admin_username"
}
variable "password" {
  type        = string
  description = "admin_password"
  sensitive   = true
}
variable "subscription_id" {
  type = string
}