terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# =========================
# RESOURCE GROUP
# =========================
resource "azurerm_resource_group" "rg" {
  name     = "rg-pm10-project"
  location = var.location
}

# =========================
# STORAGE ACCOUNT (ADLS Gen2)
# =========================
resource "azurerm_storage_account" "adls" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_container" "delta" {
  name                  = "delta"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

# =========================
# EVENT HUBS
# =========================
resource "azurerm_eventhub_namespace" "eh_ns" {
  name                = "pm10-eh-namespace"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"
}

resource "azurerm_eventhub" "pm10" {
  name                = "pm10-events"
  namespace_name      = azurerm_eventhub_namespace.eh_ns.name
  resource_group_name = azurerm_resource_group.rg.name
  partition_count     = 2
  message_retention   = 1
}

resource "azurerm_eventhub_authorization_rule" "eh_rule" {
  name                = "pm10-rule"
  namespace_name      = azurerm_eventhub_namespace.eh_ns.name
  eventhub_name       = azurerm_eventhub.pm10.name
  resource_group_name = azurerm_resource_group.rg.name

  listen = true
  send   = true
  manage = false
}

# =========================
# AZURE DATABRICKS
# =========================
resource "azurerm_databricks_workspace" "dbw" {
  name                = "pm10-databricks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "standard"
}
