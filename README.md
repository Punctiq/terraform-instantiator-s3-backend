# terraform-instantiator-s3-backend
Author: Alexandru Raul

This repository contains a Terraform "instantiator" stack that deploys the **Punctiq Terraform backend**:
- an **S3 bucket** for Terraform remote state
- a **DynamoDB table** for state locking

It is intended to be deployed **once per environment** (prod/finops/dev), then reused by other Terraform projects via `backend "s3"`.

---


### What this does
This stack instantiates the module:
- `Punctiq/terraform-aws-s3-backend`

It creates:
- **S3 bucket**: Terraform state storage (versioning, encryption, public access blocking, tags)
- **DynamoDB table**: Terraform state locking

### Repository structure (suggested)

```perl
├── main.tf
├── variables.tf
├── terraform.tfvars # DO NOT commit if it contains sensitive data
├── outputs.tf # optional (or keep outputs in main.tf)
└── README.md
```

### Prerequisites
- Terraform installed (use a real version, e.g. `~> 1.8.0` or `>= 1.8.0, < 2.0.0`)
- AWS CLI configured with a profile that can create S3 + DynamoDB resources
- Network access to AWS APIs

> Note: In `main.tf`, do not use `required_version = "~> 1.14.0"` because Terraform 1.14.x does not exist in the Terraform 1.x line. Use something like `~> 1.8.0`.

### How to deploy
## 1) Initialize:
```bash
terraform init
```
## 2) Plan:

```bash
terraform plan -var-file="terraform.tfvars"
```

## 3) Apply:

```bash
terraform apply -var-file="terraform.tfvars"
```

### Outputs

After apply, you should get outputs similar to:

- terraform_state_bucket_name
- terraform_tfstate_lock_table_name
- terraform_tfstate_lock_table_arn

Use them as input in other Terraform projects.
How to use the created backend in another Terraform project
In the root Terraform project (not inside modules), configure:

```hcl
terraform {
  backend "s3" {
    bucket         = "<OUTPUT terraform_state_bucket_name>"
    key            = "terraform.tfstate"
    region         = "<REGION>"
    dynamodb_table = "<OUTPUT terraform_tfstate_lock_table_name>"
    encrypt        = true
  }
}
```

Then run in that other project:

```bash
terraform init
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | ~> 1.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement_aws) | >= 3.0.0 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_s3_tags"></a> [backup_s3_tags](#input_backup_s3_tags) | Backup and data protection tags for S3 resources | `map(string)` | n/a | yes |
| <a name="input_billing_tags"></a> [billing_tags](#input_billing_tags) | Billing and cost allocation tags | `map(string)` | n/a | yes |
| <a name="input_business_tags"></a> [business_tags](#input_business_tags) | Business-related tags | `map(string)` | n/a | yes |
| <a name="input_dynamo_tbl_attribute_type"></a> [dynamo_tbl_attribute_type](#input_dynamo_tbl_attribute_type) | DynamoDB attribute type for the hash key | `string` | `"S"` | no |
| <a name="input_dynamo_tbl_billing_mode"></a> [dynamo_tbl_billing_mode](#input_dynamo_tbl_billing_mode) | DynamoDB billing mode | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_dynamo_tbl_hash_key"></a> [dynamo_tbl_hash_key](#input_dynamo_tbl_hash_key) | DynamoDB hash (partition) key name | `string` | `"LockID"` | no |
| <a name="input_dynamo_tbl_name"></a> [dynamo_tbl_name](#input_dynamo_tbl_name) | DynamoDB table name used for Terraform state locking | `string` | n/a | yes |
| <a name="input_dynamo_tbl_point_in_time_recovery"></a> [dynamo_tbl_point_in_time_recovery](#input_dynamo_tbl_point_in_time_recovery) | Enable point-in-time recovery for DynamoDB table | `string` | `true` | no |
| <a name="input_profile"></a> [profile](#input_profile) | AWS CLI profile used for deployment | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input_region) | AWS region where resources will be created | `string` | n/a | yes |
| <a name="input_s3_block_public_acls"></a> [s3_block_public_acls](#input_s3_block_public_acls) | Whether to block public ACLs on the S3 bucket | `string` | `true` | no |
| <a name="input_s3_block_public_policy"></a> [s3_block_public_policy](#input_s3_block_public_policy) | Whether to block public bucket policies | `string` | `true` | no |
| <a name="input_s3_bucket_name"></a> [s3_bucket_name](#input_s3_bucket_name) | S3 bucket name suffix (will be prefixed by standard naming) | `string` | n/a | yes |
| <a name="input_s3_bucket_versioning"></a> [s3_bucket_versioning](#input_s3_bucket_versioning) | Enable or disable S3 bucket versioning | `string` | `"Enabled"` | no |
| <a name="input_s3_server_side_encryption"></a> [s3_server_side_encryption](#input_s3_server_side_encryption) | S3 server-side encryption algorithm | `string` | `"AES256"` | no |
| <a name="input_security_dynamotbl_tags"></a> [security_dynamotbl_tags](#input_security_dynamotbl_tags) | Security-related tags for DynamoDB table | `map(string)` | n/a | yes |
| <a name="input_security_s3_tags"></a> [security_s3_tags](#input_security_s3_tags) | Security-related tags for S3 resources | `map(string)` | n/a | yes |
| <a name="input_technical_dynamodbtbl_tags"></a> [technical_dynamodbtbl_tags](#input_technical_dynamodbtbl_tags) | Technical tags for DynamoDB table | `map(string)` | n/a | yes |
| <a name="input_technical_s3_tags"></a> [technical_s3_tags](#input_technical_s3_tags) | Technical tags for S3 resources | `map(string)` | n/a | yes |
| <a name="input_terraform_module_version"></a> [terraform_module_version](#input_terraform_module_version) | Terraform module version used to deploy resources | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_terraform_state_bucket_name"></a> [terraform_state_bucket_name](#output_terraform_state_bucket_name) | Terraform TF state S3 bucket name |
| <a name="output_terraform_tfstate_lock_table_arn"></a> [terraform_tfstate_lock_table_arn](#output_terraform_tfstate_lock_table_arn) | DynamoDB table ARN used for Terraform state locking |
| <a name="output_terraform_tfstate_lock_table_name"></a> [terraform_tfstate_lock_table_name](#output_terraform_tfstate_lock_table_name) | DynamoDB table name used for Terraform state locking |
<!-- END_TF_DOCS -->