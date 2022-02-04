
  resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "5.1.3"
  namespace  = "kube-system"

  values = [
    "${file("./chart_values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  depends_on = [local_file.kubeconfig_EKS_Cluster]

}