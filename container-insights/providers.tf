terraform {
  required_providers {
    aws = {

      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    key    = "container-insights-state"
    bucket = "aram-dasmeta-task-state"
    region = "eu-north-1"


  }
}

provider "aws" {
  region  = var.region
  profile = "default"
}

provider "kubernetes" {
  # config_path = "~/.kube/config"
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name, "--region", "eu-north-1"]
    command     = "aws"
  }

}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name, "--region", "eu-north-1"]
      command     = "aws"
    }
  }
}