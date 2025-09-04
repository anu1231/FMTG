variable "name" {
  description = "Name prefix for networking resources"
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

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Address prefixes for subnets"
  type        = map(list(string))
  default = {
    "app"      = ["10.0.1.0/24"]
    "bastion"  = ["10.0.2.0/27"]
  }
}
