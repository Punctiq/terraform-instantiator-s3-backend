#############################################
# aws-s3-backend/terraform.tfvars
# Author: Alexandru Raul
#############################################

########################
# Standards
########################
#s3_standard_bucket_name  = "tfstate-prod"
terraform_module_version = "1.0.0"

region  = "eu-central-1"
profile = "punctiq-prod"

########################
# S3 variables
########################
# <= 40 chars
s3_bucket_name = "core"

# Allowed: "Enabled" or "Disabled"
s3_bucket_versioning = "Enabled"

# NOTE:
# In your variables, these are declared as string but defaults are boolean.
# Your validation checks for "true"/"false".
# Keep them as strings to satisfy current validation.
s3_block_public_acls   = "true"
s3_block_public_policy = "true"

# Allowed: "AES256" | "aws:kms" | "aws:kms:dsse"
s3_server_side_encryption = "AES256"

########################
# DynamoDB variables
########################
# <= 30 chars (your error message says 20, but condition is 30)
dynamo_tbl_name = "punctiq-tf-lock"

# Defaults already match, but we set explicitly
dynamo_tbl_hash_key       = "LockID"
dynamo_tbl_attribute_type = "S"
dynamo_tbl_billing_mode   = "PAY_PER_REQUEST"

# NOTE:
# Declared as string, default is boolean true, validation expects "true"/"false"
dynamo_tbl_point_in_time_recovery = "true"

########################
# Tags
########################

# Must have EXACTLY 9 keys (per your validation) and values lowercase.
business_tags = {
  "punctiq:business:project"               = "punctiq-workloads-production"
  "punctiq:business:owner"                 = "alexandru-raul"
  "punctiq:business:charge_to_id"          = "internal"
  "punctiq:business:businessunit"          = "finops"
  "punctiq:business:wbs"                   = "na"
  "punctiq:business:stakeholder"           = "punctiq-platform-team"
  "punctiq:business:impact"                = "high"
  "punctiq:business:dedicated:client_name" = "internal"
  "punctiq:business:dedicated:country"     = "de"
}

# Must have EXACTLY 7 keys and values lowercase.
technical_s3_tags = {
  "punctiq:s3:technical:stack"             = "terraform"
  "punctiq:s3:technical:deployment_method" = "iac"
  "punctiq:s3:technical:versioning"        = "enabled"
  "punctiq:s3:technical:replication"       = "none"
  "punctiq:s3:technical:lifecycle"         = "none"
  "punctiq:s3:technical:logging"           = "none"
  "punctiq:s3:technical:notification"      = "none"
}

# Must have EXACTLY 7 keys and values lowercase.
technical_dynamodbtbl_tags = {
  "punctiq:dynamotbl:technical:stack"             = "terraform"
  "punctiq:dynamotbl:technical:deployment_method" = "iac"
  "punctiq:dynamotbl:technical:versioning"        = "na"
  "punctiq:dynamotbl:technical:replication"       = "na"
  "punctiq:dynamotbl:technical:lifecycle"         = "na"
  "punctiq:dynamotbl:technical:logging"           = "na"
  "punctiq:dynamotbl:technical:notification"      = "na"
}

# Must have EXACTLY 6 keys and values lowercase.
security_s3_tags = {
  "punctiq:s3:security:compliance"        = "internal"
  "punctiq:s3:security:classification"    = "confidential"
  "punctiq:s3:security:encryption"        = "enabled"
  "punctiq:s3:security:level"             = "high"
  "punctiq:s3:security:incident_response" = "standard"
  "punctiq:s3:security:access_control"    = "restricted"
}

# Must have EXACTLY 6 keys and values lowercase.
security_dynamotbl_tags = {
  "punctiq:dynamotbl:security:compliance"        = "internal"
  "punctiq:dynamotbl:security:classification"    = "confidential"
  "punctiq:dynamotbl:security:encryption"        = "enabled"
  "punctiq:dynamotbl:security:level"             = "high"
  "punctiq:dynamotbl:security:incident_response" = "standard"
  "punctiq:dynamotbl:security:access_control"    = "restricted"
}

# Must have EXACTLY 4 keys and values lowercase.
billing_tags = {
  "punctiq:billing:credit"        = "no"
  "punctiq:billing:account_name"  = "punctiq-workloads-production"
  "punctiq:billing:contact_name"  = "alexandru-raul"
  "punctiq:billing:contact_email" = "billing@punctiq.io"
}

# Must have EXACTLY 5 keys and values lowercase.
backup_s3_tags = {
  "punctiq:backup:s3"                  = "tfstate"
  "punctiq:backup:charge_to_id"        = "internal"
  "punctiq:backup:frequency"           = "continuous"
  "punctiq:backup:owner"               = "punctiq-platform-team"
  "punctiq:backup:data_classification" = "confidential"
}
