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

variable "client_id" {
  description = "The Client ID which should be used."
  type        = string
}

variable "nsg_rules" {
  description = "List of NSG rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = []
  
}