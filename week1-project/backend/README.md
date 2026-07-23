# Terraform Backend

This directory provisions the shared backend resources (S3 + DynamoDB) used by the root project in `../`.

## Usage

1. Pick a globally unique S3 bucket name and create a `terraform.tfvars` file:

   ```hcl
   bucket_name = "my-unique-hug-terraform-state-bucket"
   ```

2. Deploy the backend resources:

   ```bash
   cd backend
   terraform init
   terraform plan
   terraform apply
   ```

3. Note the outputs and use them to configure the backend block in `../providers.tf`.
