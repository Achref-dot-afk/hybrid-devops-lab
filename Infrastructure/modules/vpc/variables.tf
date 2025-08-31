variable "environment" {
  description = "Environment in which we deploy resources"
  type = string
}

variable "rg_name" {
  description = "Resource Group"
  type = string
}

variable "location" {
  description = "Location of resources"
  type = string
}