variable "environment" {
  description = "Environment in which we deploy resources"
  type = string
}

variable "location" {
  description = "Location of resources"
  type = string
}

variable "subscription_id" {
  description = "The Subscription ID which should be used."
  type        = string
}

variable "tenant_id" {
  description = "The Tenant ID which should be used."
  type        = string
}

variable "client_id" {
  description = "The Client ID which should be used."
  type        = string
}
