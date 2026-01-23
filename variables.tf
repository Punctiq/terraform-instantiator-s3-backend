# ==========================================================
# Author: Alexandru Raul
# File: variables.tf
# ==========================================================

########################
# Standards
########################

#variable "s3_standard_bucket_name" {
#  type        = string
##  description = "Standard S3 bucket prefix for Terraform state"
 # default     = "tfstate-prod"
#}

variable "region" {
  type        = string
  description = "AWS region where resources will be created"
}

#variable "profile" {
#  type        = string
#  description = "AWS CLI profile used for deployment"#
#}

variable "terraform_module_version" {
  type        = string
  description = "Terraform module version used to deploy resources"
}

########################
# S3 variables
########################

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name suffix (will be prefixed by standard naming)"
}

variable "s3_bucket_versioning" {
  type        = string
  description = "Enable or disable S3 bucket versioning"
  default     = "Enabled"
}

variable "s3_block_public_acls" {
  type        = string
  description = "Whether to block public ACLs on the S3 bucket"
  default     = true
}

variable "s3_block_public_policy" {
  type        = string
  description = "Whether to block public bucket policies"
  default     = true
}

variable "s3_server_side_encryption" {
  type        = string
  description = "S3 server-side encryption algorithm"
  default     = "AES256"
}

########################
# DynamoDB variables
########################

variable "dynamo_tbl_name" {
  type        = string
  description = "DynamoDB table name used for Terraform state locking"
}

variable "dynamo_tbl_attribute_type" {
  type        = string
  description = "DynamoDB attribute type for the hash key"
  default     = "S"
}

variable "dynamo_tbl_hash_key" {
  type        = string
  description = "DynamoDB hash (partition) key name"
  default     = "LockID"
}

variable "dynamo_tbl_billing_mode" {
  type        = string
  description = "DynamoDB billing mode"
  default     = "PAY_PER_REQUEST"
}

variable "dynamo_tbl_point_in_time_recovery" {
  type        = string
  description = "Enable point-in-time recovery for DynamoDB table"
  default     = true
}

########################
# Tagging
########################

## Business tags
variable "business_tags" {
  type        = map(string)
  description = "Business-related tags"
}

## Technical tags
variable "technical_s3_tags" {
  type        = map(string)
  description = "Technical tags for S3 resources"
}

variable "technical_dynamodbtbl_tags" {
  type        = map(string)
  description = "Technical tags for DynamoDB table"
}

## Security tags
variable "security_s3_tags" {
  type        = map(string)
  description = "Security-related tags for S3 resources"
}

variable "security_dynamotbl_tags" {
  type        = map(string)
  description = "Security-related tags for DynamoDB table"
}

## Billing tags
variable "billing_tags" {
  type        = map(string)
  description = "Billing and cost allocation tags"
}

## Backup tags
variable "backup_s3_tags" {
  type        = map(string)
  description = "Backup and data protection tags for S3 resources"
}

#Deployment TAGS
variable "deployment_tags_static" {
   description = "AWS deployment TAGS"
  type    = map(string)
}

variable "tag_build_number" {
  description = "Build number, taken from  Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_author" {
  description = "Deployment author, taken from  Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_hash" {
  description = "GIT hash, taken from  Jenkins"
  type        = string
  default     = ""
}

variable "tag_build_job_name" {
  description = "Job name, taken from  Jenkins"
  type        = string
  default     = ""
}
#End Deployment TAGS
