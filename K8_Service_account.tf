# https://github.com/kubernetes-sigs/kubespray/issues/5347

resource "kubernetes_service_account" "dashboard_admin" {
  metadata {
    name      = "dashboard-admin"
    namespace = "kube-system"
  }
  depends_on = [local_file.kubeconfig_EKS_Cluster]
}

resource "kubernetes_cluster_role_binding" "dashboard_admin" {
  metadata {
    name = "dashboard_admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name = kubernetes_service_account.dashboard_admin.metadata.0.name
    namespace = kubernetes_service_account.dashboard_admin.metadata.0.namespace
  }

  provisioner "local-exec" {
    command = "sleep 15"
  }

  depends_on = [local_file.kubeconfig_EKS_Cluster]

}

data "kubernetes_secret" "dashboard-admin" {
  metadata {
    name = kubernetes_service_account.dashboard_admin.default_secret_name
    namespace = kubernetes_service_account.dashboard_admin.metadata.0.namespace
  }

  depends_on = [kubernetes_service_account.dashboard_admin]
}
