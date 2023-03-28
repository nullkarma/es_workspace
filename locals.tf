/**
* kibana features contains all features for each menu category. The list is used to invert the selection of features of a configured kibana space.
* Usually you'd have to pass the list of features to be disabled. Most of the time we want users to have only a hand full features enabled.
* Therefore we pass the features we'd like to have enabled and apply setsubtract on all_kibana_features and kibana_features from the module inputs.
* In conclusion `kibana_features` has only a few list items instead of `all_kibana_features` - `features_id_like_to_have_enabled`.
* See examples for more details.
*/
locals {
  kibana_features = {
    analytics     = ["discover", "dashboard", "canvas", "maps", "ml", "visualize"]
    observability = ["logs", "infrastructure", "apm", "uptime", "observabilityCases"]
    security      = ["siem", "securitySolutionCases"]
    management    = ["advancedSettings", "indexPatterns", "savedObjectsManagement", "savedObjectsTagging", "osquery", "actions", "generalCases", "stackAlerts", "fleet", "fleetv2", "monitoring"]
  }
  all_kibana_features = setunion(flatten([local.kibana_features.analytics, local.kibana_features.observability, local.kibana_features.security, local.kibana_features.management]))
}

locals {
  indices = [for i in var.indices : i.names]
}
