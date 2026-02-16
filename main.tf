resource "azurerm_resource_group" "rg" {
  name     = var.rg_name #"azuremedha"
  location = var.location #"canada central"
}

module "cici_network_infra"{
    source = "./modules/network"
    subnet_name = var.subnet_name
    sg_name = var.sg_name
    network_name = var.network_name





} 



 

 
