variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
  default     = "pixelops"
}

variable "app_namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
  default     = "webapp"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}