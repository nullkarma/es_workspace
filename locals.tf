locals {
  kibana_features = {
    analytics     = ["discover", "dashboard", "canvas", "maps", "ml", "visualize"]
    observability = ["logs", "infrastructure", "apm", "uptime", "observabilityCases"]
    security      = ["siem", "securitySolutionCases"]
    management    = ["advancedSettings", "indexPatterns", "savedObjectsManagement", "savedObjectsTagging", "osquery", "actions", "generalCases", "stackAlerts", "fleet", "fleetv2", "monitoring"]
  }
  all_kibana_features = setunion(flatten([local.kibana_features.analytics, local.kibana_features.observability, local.kibana_features.security, local.kibana_features.management]))
}

