resource "azurerm_application_insights" "appinsights" {
  name                = var.appInsights
  location            = var.location
  resource_group_name = var.resourceGroupName
  application_type    = "web"
}


output "instrumentation_key" {
  value = azurerm_application_insights.appinsights.instrumentation_key
}

output "app_id" {
  value = azurerm_application_insights.appinsights.app_id
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "workspace-test"
  location            = var.location
  resource_group_name = var.resourceGroupName
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault
  location                    = var.location
  resource_group_name         = var.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

}

resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb
  location            = var.location
  resource_group_name = var.resourceGroupName
  offer_type          = "Standard"
}
