# variable "client_secret" {
# }

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.60.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = "bc2ee156-191f-439a-ba8f-7f3ec15767db"
  tenant_id       = "e2b45068-7762-4de3-95f9-d44c84e0e45d"
  subscription_id = "7b8e0fae-d37a-4089-a683-cc71a03488c6"
}