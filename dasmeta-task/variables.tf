variable "azs" {
  
  type = list
  description = "List of availability zones"
}

variable "private_subnets" {
  
  type = list
  description = "List of private subnets"
}

variable "public_subnets" {
  
  type = list
  description = "List of public subnets"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"   
}

variable "vpc_cidr" {
  type = string
  description = "CIDR Block of the VPC"
  
}

variable "eks_cluster_name" {
  type = string
  description = "Cluster Name"
  
}

variable "capacity_type" {
  type = string
  description = "Capacity type for EKS"
}

variable "eks_instance_types" {
  type = list
  description = "EKS Instance Type used"
}

variable "node_group_desired_size" {
  type = number
  description = "Amount of desired nodes"
}


variable "node_group_min_size" {
  type = number
  description = "Amount of min nodes"
}


variable "node_group_max_size" {
  type = number
  description = "Amount of max nodes"
}