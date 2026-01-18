#############################################
# Outputs (pass-through)
#############################################
output "terraform_state_bucket_name" {
  description = "Terraform TF state S3 bucket name"
  value       = module.aws_s3_backend.terraform_state_bucket_name
}

output "terraform_tfstate_lock_table_name" {
  description = "DynamoDB table name used for Terraform state locking"
  value       = module.aws_s3_backend.terraform_tfstate_lock_table_name
}

output "terraform_tfstate_lock_table_arn" {
  description = "DynamoDB table ARN used for Terraform state locking"
  value       = module.aws_s3_backend.terraform_tfstate_lock_table_arn
}