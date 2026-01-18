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

<!-- END_TF_DOCS -->