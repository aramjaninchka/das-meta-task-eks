module "eks_blueprints_addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.22.0"



  cluster_name      = data.aws_eks_cluster.cluster.name
  cluster_endpoint  = data.aws_eks_cluster.cluster.endpoint
  cluster_version   = data.aws_eks_cluster.cluster.version
  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  enable_aws_load_balancer_controller = false
  # aws_load_balancer_controller = {
  #   wait        = true
  #   role_name   = "${data.aws_eks_cluster.cluster.name}-alb-controller"
  #   policy_name = "${data.aws_eks_cluster.cluster.name}-alb-controller"
  # }

  observability_tag = null
}

resource "time_sleep" "blueprints_addons_sleep" {
  depends_on = [
    module.eks_blueprints_addons
  ]

  create_duration = "15s"
}

resource "kubernetes_namespace" "opentelemetry_operator" {
  metadata {
    name = "opentelemetry-operator-system"
  }
}

module "cert_manager" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "1.1.1"

  depends_on = [
    time_sleep.blueprints_addons_sleep
  ]

  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  wait             = true
  chart            = "cert-manager"
  chart_version    = "v1.15.1"
  repository       = "https://charts.jetstack.io"

  set = [
    {
      name  = "crds.enabled"
      value = true
    }
  ]
}

module "opentelemetry_operator" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "1.1.1"

  depends_on = [
    module.cert_manager
  ]

  name             = "opentelemetry"
  namespace        = kubernetes_namespace.opentelemetry_operator.metadata[0].name
  create_namespace = false
  wait             = true
  chart            = "opentelemetry-operator"
  chart_version    = var.operator_chart_version
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"

  set = [{
    name  = "manager.collectorImage.repository"
    value = "otel/opentelemetry-collector-k8s"
  }]
}