
# K8 dashboard service account token
output "dashboard_admin_token" {
  sensitive = true
  value = data.kubernetes_secret.dashboard-admin.data.token
}
