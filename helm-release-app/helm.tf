# resource "helm_release" "nginx" {

#   name       = "nginx"
#   repository = "https://charts.bitnami.com/bitnami"
#   chart      = "nginx"

#   values = [
#     file("${path.module}/nginx-values.yaml")
#   ]

# }

resource "helm_release" "test_redis" {
  name       = "test-redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  
  set {
    name  = "metrics.enabled"
    value = "true"
  }
  
  set {
    name  = "auth.enabled"
    value = "false"  # For testing only
  }
}