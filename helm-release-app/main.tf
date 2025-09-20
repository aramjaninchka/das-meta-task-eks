resource "helm_release" "nginx_test" {
  name       = "nginx-test"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  namespace  = "default"
  
}