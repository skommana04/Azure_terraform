 variable "rg_name" {}
 variable "location" {}
  variable "sg_name" {
    type = list()
    description = "security group for roboshop"
}

variable "network_name" {
    type = string
    description = "network for roboshop"
    default = "medha"
}

variable "public_subnet_name" {}
variable "private_subnet_name" {} 
variable "address_space" {}     
variable "private_subnet_address_prefixes" {}  
variable "public_subnet_address_prefixes" {}  
variable "network_rules" {}
variable "private_subnet_nsg_name" {}