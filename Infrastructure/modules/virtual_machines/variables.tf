
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

variable "master_subnet_id" {
  description = "The ID of the master subnet"
  type = string
}

variable "worker_subnet_id" {
  description = "The ID of the worker subnet"
  type = string
}

variable "ssh_key" {
  description = "SSH public key of master node"
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCJAEPGMsXGhyt12lE+cniIpV4VjzevE40a/l7L+5sNZ3JgB9PwFB+H2LcU0d0taSV6me2Sf3A3PnzxDGzhI/KwN5yLSkSmCHlOekdQU/Vpfjat7Xo7P5aCH9uXXe/h/0n3RfnpnQ3DVGF5nl8sen/x+pIt8TBGaCDoxWDjL7XILg4LLMGfQONaOe2caJashL7vIOor45759LybrTPRyNnbN3lSPs1CqLheK07yzFc45kRFkghBE1AChb/qJYcw/tOaoPUOFU4goAAGOxFhhddd/JpyTHP66+xRhCsIqSI+w2GcfTyQmwM7w/osZsYf8TvY6WPmry5bI2+EKGtGnkzj rsa-key-20250828"
  
}

variable "worker_ssh_key" {
  description = "SSH public key of worker node"
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCLjiVaMPA3wXr97CDX0kk1rlBzW6CN0lyFRoPPJKarcpbeyN1YAWEigA6oF4HiAKxJ7QYxBA/QP72J6wZvF1vZ/4zb6yDfcXNRGqsb22k6tCF4ryxeGSdaX+4NrasK0bNuwkPtwDMb8PJmwX8vznmeICcRCRI5MYLJH7M6maGs/T1P6VcBXqWP63FdCAZ+baLH4gWGTb+E/My9msEGor0+vCaTF582SwbXXKpD4LBukU+KvEdg+m8IGmHIGoOObpj0f+md6fpr3xDQtgq4nDlSCpvDj9STEwjNSZAQY+X8rJDS4ElQW4Ct5sCBKyQxb8S3RiTv6rLDHMtUj7lBEpTf rsa-key-20250917"
  
}

variable "nsg_rules" {
  description = "List of NSG Rules"
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