# Configure the Azure Provider
provider "azurerm" {
  features {}
 subscription_id = ""
  tenant_id       = ""
  client_id     = ""
  client_secret = ""

}

# Define a Resource Group
resource "azurerm_resource_group" "example" {
  name     = "sample-resource"
  location = "East US"
}

# Define a Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "arm-virtual-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

# Define a Subnet
resource "azurerm_subnet" "example" {
  name                 = "sample-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Define an Azure Container Registry
resource "azurerm_container_registry" "example" {
  name                = "sampleacr12"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Define an AKS Cluster
resource "azurerm_kubernetes_cluster" "example" {
  name                = "sample-akscluster"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name       = "default"
    node_count = 3
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "testing"
  }

}


