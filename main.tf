#############################################
# instantiator/main.tf
# Author: Alexandru Raul
# Purpose: Instantiate aws-s3-backend module using terraform.tfvars
#############################################

terraform {
  required_version = "~> 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}

#############################################
# Provider
#############################################
provider "aws" {
  region  = var.region
  profile = var.profile
   assume_role {
    role_arn = "arn:aws:iam::791954933608:role/PunctiqTerraformProvisionerRole"
  }
}

#############################################
# Module instantiation
#############################################
module "aws_s3_backend" {
  # CHANGE THIS to your real module path or git source
  # Example local path:
  source = "git::https://github.com/Punctiq/terraform-aws-s3-backend.git?ref=main"


  ###########################################
  # Standards
  ###########################################
  s3_standard_bucket_name  = "tfstate-prod"  # enforced by your module validation
  terraform_module_version = var.terraform_module_version

  region  = var.region
  profile = var.profile

  ###########################################
  # S3
  ###########################################
  s3_bucket_name             = var.s3_bucket_name
  s3_bucket_versioning       = var.s3_bucket_versioning
  s3_block_public_acls       = var.s3_block_public_acls
  s3_block_public_policy     = var.s3_block_public_policy
  s3_server_side_encryption  = var.s3_server_side_encryption

  ###########################################
  # DynamoDB
  ###########################################
  dynamo_tbl_name                  = var.dynamo_tbl_name
  dynamo_tbl_hash_key              = var.dynamo_tbl_hash_key
  dynamo_tbl_attribute_type        = var.dynamo_tbl_attribute_type
  dynamo_tbl_billing_mode          = var.dynamo_tbl_billing_mode
  dynamo_tbl_point_in_time_recovery = var.dynamo_tbl_point_in_time_recovery

  ###########################################
  # Tags
  ###########################################
  business_tags              = var.business_tags
  technical_s3_tags          = var.technical_s3_tags
  technical_dynamodbtbl_tags = var.technical_dynamodbtbl_tags
  security_s3_tags           = var.security_s3_tags
  security_dynamotbl_tags    = var.security_dynamotbl_tags
  billing_tags               = var.billing_tags
  backup_s3_tags             = var.backup_s3_tags
}