data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "aram-dasmeta-task-state"
    key    = "eks-state"
    region = "eu-north-1"
  }

}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}
