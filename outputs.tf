output "team" {
  value = var.name
}

output "workspace_id" {
  value = kibana_user_space.this.id
}