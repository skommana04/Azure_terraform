resource "azurerm_resource_group" "rg" {
  name     = var.rg_name  #azuremedha
  location = var.location #canada central
}

# in this module cicd_network_infra, I am creating vnet,sg and subnet

module "cicd_network_infra" {
  source = "git::https://github.com/your-username/Azure-terraform-modules.git//vnet?ref=main"

  rg_name                         = var.rg_name
  location                        = var.location
  sg_name                         = var.sg_name
  network_name                    = var.network_name
  public_subnet_name              = var.public_subnet_name
  private_subnet_name             = var.private_subnet_name
  address_space                   = var.address_space
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  public_subnet_address_prefixes  = var.public_subnet_address_prefixes
  network_rules                   = var.network_rules
  private_subnet_nsg_name         = var.private_subnet_nsg_name

}