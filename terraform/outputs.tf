output "eventhub_name" {
  value = azurerm_eventhub.pm10.name
}

output "eventhub_connection_string" {
  value     = azurerm_eventhub_authorization_rule.eh_rule.primary_connection_string
  sensitive = true
}

output "databricks_url" {
  value = azurerm_databricks_workspace.dbw.workspace_url
}
