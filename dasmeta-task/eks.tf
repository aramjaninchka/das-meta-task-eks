module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.9"
  name               = var.eks_cluster_name
  kubernetes_version = "1.31"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  authentication_mode = "API_AND_CONFIG_MAP"
  endpoint_public_access = true # probably not best practice would have tried to set up VPN, if no time constraints

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
#   control_plane_subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      
      instance_types = var.eks_instance_types
      capacity_type = var.capacity_type

      min_size     = var.node_group_min_size
      max_size     = var.node_group_max_size
      desired_size = var.node_group_desired_size
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
