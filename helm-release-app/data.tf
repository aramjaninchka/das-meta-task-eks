data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "aram-dasmeta-task-state"
    key    = "terraform.tfstate"
    region = var.region
  }

}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "kubernetes_service" "nginx" {
  depends_on = [helm_release.nginx]
  metadata {
    name = "nginx"
  }
}