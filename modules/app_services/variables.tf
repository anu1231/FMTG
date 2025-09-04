variable "name" {
  description = "Name prefix for App Service resources"
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

variable "container_image" {
  description = "Docker image for the App Service"
  type        = string
}

variable "app_settings" {
  description = "App settings for App Service"
  type        = map(string)
  default     = {}
}
