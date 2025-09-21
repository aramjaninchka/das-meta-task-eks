# variable "eks_cluster_id" {
#   description = "EKS cluster name"
#   type        = string
# }
# variable "eks_cluster_version" {
#   description = "EKS cluster version"
#   type        = string
# }

# variable "cluster_security_group_id" {
#   description = "EKS cluster security group ID"
#   type        = any
# }


# variable "tags" {
#   description = "Tags to apply to AWS resources"
#   type        = any
#   default = "terraform"
# }

# variable "resources_precreated" {
#   description = "Have expensive resources been created already"
#   type        = bool
# }

variable "operator_chart_version" {
  description = "The chart version of opentelemetry-operator to use"
  type        = string
  # renovate-helm: depName=opentelemetry-operator registryUrl=https://open-telemetry.github.io/opentelemetry-helm-charts
  default = "0.68.1"
}

variable "region" {
  description = "Region of AWS Account"
  type        = string
  default     = "eu-north-1"

}