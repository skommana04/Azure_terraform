terraform {
  backend "azurerm" {
    resource_group_name  = "backend_resource_group" # The RG where storage lives
    storage_account_name = "medhastate2026"         # The globally unique name
    container_name       = "medhatfbucket"          # The "Bucket"
    key                  = "terraform.tfstate"      # The file name

  }
}