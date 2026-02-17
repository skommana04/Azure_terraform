resource "azurerm_resource_group" "rg" {
  name     = var.rg_name  #azuremedha
  location = var.location #canada central
}

# in this module cicd_network_infra, I am creating vnet,sg and subnet

module "cicd_network_infra" {
  source = "git::https://github.com/skommana04/Azure_terraform_modules.git//modules/network?ref=main"

  rg_name                         = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
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

module "public_vms" {
  for_each = toset(var.vm_name)
  source   = "git::https://github.com/skommana04/Azure_terraform_modules.git//modules/vm?ref=main"

  rg_name   = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
  subnet_id = module.cicd_network_infra.public_subnet_id
  #instance_count = length(var.vm_name)
  vm_name = each.value

  depends_on = [
    module.cicd_network_infra
  ]

}

resource "azurerm_container_registry" "roboshop_acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_service_plan" "roboshop_svc_plan" {
  name                = "robotshop-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

module "web_apps_service" {

  source      = "git::https://github.com/skommana04/Azure_terraform_modules.git//modules/webapp?ref=main"
  acr_name    = var.acr_name
  for_each    = var.web_apps
  rg_name     = azurerm_resource_group.rg.name
  location    = azurerm_resource_group.rg.location
  service_plan_id  = azurerm_service_plan.roboshop_svc_plan.id
  acr_login_server = azurerm_container_registry.roboshop_acr.login_server
  acr_id           = azurerm_container_registry.roboshop_acr.id
  webapp_name = each.key
  image_name  = each.value.image
  env_vars    = local.app_env_config[each.key]

  depends_on = [
    module.cicd_network_infra,
    module.public_vms
  ]
}