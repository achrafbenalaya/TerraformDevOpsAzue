

provider "azurerm" {
    # The "feature" block is required for AzureRM provider 2.x.
    # If you're using version 1.x, the "features" block is not allowed.
    version = "~>2.0"
    features {}
}
 
terraform {
  backend "azurerm" {}
}
data "azurerm_client_config" "current" {}
 

 #here we are going to create a new resource groupe called : hellodemo-01
resource "azurerm_resource_group" "achrafrg" {
  name     = "hellodemo-01"
  location = "francecentral"
}
 

# #  #in the previous group now we are going to create a storage account named demostorage001
# resource "azurerm_storage_account" "demoachraf" {
#   name                     = "demoachrafstorage0001"
#   resource_group_name      = azurerm_resource_group.achrafrg.name
#   location                 = azurerm_resource_group.achrafrg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

resource "azurerm_app_service_plan" "example" {
  name                = "terrafplanwebapp"
  location            = azurerm_resource_group.achrafrg.location
  resource_group_name = azurerm_resource_group.achrafrg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "appnameusingterraform2021"
  location            = azurerm_resource_group.achrafrg.location
  resource_group_name = azurerm_resource_group.achrafrg.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
