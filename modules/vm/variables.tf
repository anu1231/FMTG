variable "name" {
  description = "Name of the VM"
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
  description = "Subnet ID where VM will be placed"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "Path to SSH public key file"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B2ms"
}

variable "cloud_init_file" {
  description = "Path to cloud-init YAML file"
  type        = string
  default     = ""
}
