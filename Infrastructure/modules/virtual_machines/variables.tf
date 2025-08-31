
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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCupF1jr1MkZMmvKU+9VNYaPbsHFrwRwXnQVFB/2oRKaMl0iQaA9j0o+9bqhM+9InmWLRZGe4cPfOnHJvUPlP7iSja5ur7Wb6W9hggRDnphXOpNAit6DGachKBXPeGiI16kcXG7Nv1EvjJp2UpPTzfvlU1N5ZvGfpxfvya2eVQKPUuErq1IBgUkh174UTSWGDt2XW88Q09Ejrd6xvHNiy3JnTQlPW64NIdg81JsolTnNUzUIJPEc0yeEkB4OaU2U9hdDr8STOsGncTxDtuS4r9jvGDuaAeLp7CeI2Mr+dVjILkQQ3/ntOK2alTHJfARaRcGuPKNZFTyZsrSfJlfYZe1 rsa-key-20250828"
  
}