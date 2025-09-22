resource "kubernetes_namespace" "webapp_namespace" {
  metadata {
    name = var.app_namespace
    labels = {
      name        = var.app_namespace
      app         = "pixelops"
      environment = var.environment
    }
  }
}


resource "kubernetes_config_map" "webapp_html" {
  metadata {
    name      = "pixelops-html"
    namespace = kubernetes_namespace.webapp_namespace.metadata[0].name
  }

  data = {
    "index.html" = file("./web.html")
  }
}


resource "helm_release" "pixelops_webapp" {
  name       = var.app_name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"
  version    = "15.14.2"
  namespace  = kubernetes_namespace.webapp_namespace.metadata[0].name

  values = [
    yamlencode({
      fullnameOverride = var.app_name
      
      resources = {
        limits = {
          cpu    = "200m"
          memory = "256Mi"
        }
        requests = {
          cpu    = "100m"
          memory = "128Mi"
        }
      }

      replicaCount = 2

      service = {
        type = "LoadBalancer"  # Changed to LoadBalancer
        ports = {
          http = 80
        }
      }

      # Remove the conflicting probe configurations
      # Let the chart use its defaults

      # Custom nginx configuration
      serverBlock = <<-EOT
        server {
          listen 0.0.0.0:8080;
          server_name _;
          
          location / {
            root /app;
            index index.html;
          }
          
          location /health {
            return 200 "healthy\n";
            add_header Content-Type text/plain;
          }
        }
      EOT

      # Extra volumes to mount our HTML
      extraVolumes = [
        {
          name = "html-content"
          configMap = {
            name = kubernetes_config_map.webapp_html.metadata[0].name
          }
        }
      ]

      extraVolumeMounts = [
        {
          name      = "html-content"
          mountPath = "/app"
          readOnly  = true
        }
      ]

      podLabels = {
        app       = "pixelops"
        component = "webapp"
        version   = "v1.0.0"
      }
    })
  ]

  depends_on = [
    kubernetes_config_map.webapp_html
  ]
}