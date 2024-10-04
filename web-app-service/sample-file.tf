provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westus"
}

resource "azurerm_app_service_plan" "example" {
  name                = "application-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved             = true # This should be true for Linux-based App Service Plan
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "pro-app-serv12"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  
   site_config {
    java_version = "11"
    java_container = "TOMCAT"
    java_container_version = "8.5"
  }
 
   app_settings = {
    "JAVA_VERSION" = "11"
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"  # If using Node.js as well
    "DIAGNOSTICS_ENABLED" = "true"  # Custom setting to enable diagnostics
  }
 
}

