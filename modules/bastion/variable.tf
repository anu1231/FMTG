variable "name" {
  description = "Name of the Bastion host"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Bastion subnet (must be named AzureBastionSubnet)"
  type        = string
}
