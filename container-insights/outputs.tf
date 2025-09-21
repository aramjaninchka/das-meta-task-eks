output "adot_collector_iam_role_arn" {
  description = "IAM role ARN for the ADOT collector"
  value       = module.iam_assumable_role_adot_ci.iam_role_arn
}
