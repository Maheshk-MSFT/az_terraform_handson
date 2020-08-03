# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "=2.20.0"
  features {}
  subscription_id = "38e1b8c4-c5bc-4dd5-a7e0-e909b45f4fad"
  tenant_id       = "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "my-prod-rg"
  location = "eastus2"
}
# Create a virtual network within the resource group
resource "azurerm_virtual_network" "rg1" {
  name                = "example1-network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}
