# HUG Lagos/Ibadan Terraform Challenge — Basic Web Server

A minimal Terraform project that provisions an Nginx web server on AWS inside a custom VPC.

## Architecture

- **VPC** (`10.0.0.0/16`)
- **Public Subnet** (`10.0.1.0/24`) with automatic public IP assignment
- **Internet Gateway** for outbound/inbound internet access
- **Route Table** routing `0.0.0.0/0` to the Internet Gateway
- **Security Group** allowing:
  - SSH (`22`) from a configurable CIDR
  - HTTP (`80`) from anywhere
- **EC2 Instance** (Ubuntu 22.04 LTS, `t2.micro`) bootstrapped with `user_data` to install Nginx and serve a simple HTML page.
- **Optional remote state backend** (`backend/`): S3 bucket for state storage and DynamoDB table for state locking.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.5.0`
- An AWS account
- AWS credentials configured locally (e.g., via `aws configure` or environment variables)
- A local SSH public key file (optional, only needed if you want SSH access)

## Backend Setup (Optional)

By default, Terraform stores state locally. To use remote state with locking, deploy the backend resources first:

1. **Provision the S3 bucket and DynamoDB table:**

   ```bash
   cd backend
   terraform init
   terraform plan
   terraform apply
   ```
    ![alt text](/images/image.png)
    ![alt text](/images/s3.png)

2. **Connect the root project to the backend:**

   Note the `s3_bucket_name` output, then open `../providers.tf` and uncomment the `backend "s3"` block. Replace `REPLACE_WITH_BACKEND_S3_BUCKET_NAME` with the actual bucket name.

3. **Re-initialize the root project to migrate state:**

   ```bash
   cd ..
   terraform init
   ```

> The S3 bucket name must be globally unique. Skip this section if you prefer to keep state local.

## Quick Start

1. **Clone the repository and enter the project directory.**

   If using remote state, complete the [Backend Setup](#backend-setup-optional) steps first.

2. **Configure your deployment:**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

   Edit `terraform.tfvars` and replace the values, especially `user_full_name`:

    ```hcl
    aws_region      = "us-east-1"
    environment     = "dev"
    user_full_name  = "Your Full Name"
    key_name        = null
    public_key_path = "/home/user/.ssh/id_rsa.pub"
    ```

    To use an AWS-managed key pair instead, set `key_name` as `null` and `public_key_path`.

3. **Initialize Terraform:**

   ```bash
   terraform init
   ```

4. **Review the execution plan:**

   ```bash
   terraform plan
   ```

5. **Apply the infrastructure:**

   ```bash
   terraform apply
   ```

6. **Access the web page:**

   After `apply` completes, open the URL shown in the `website_url` output:

   ```bash
   terraform output website_url
   ```

## Useful Commands

| Command | Purpose |
|---------|---------|
| `terraform init` | Download providers and initialize the working directory |
| `terraform plan` | Preview changes before applying |
| `terraform apply` | Create or update infrastructure |
| `terraform output` | Show output values (public IP, URL, IDs) |
| `terraform destroy` | Tear down all provisioned resources |

## Outputs

- `vpc_id` — ID of the created VPC
- `public_subnet_id` — ID of the public subnet
- `security_group_id` — ID of the web security group
- `instance_id` — ID of the EC2 instance
- `instance_public_ip` — Public IP of the web server
- `website_url` — Direct link to the Nginx landing page

## Cleanup

To avoid ongoing AWS charges, destroy the infrastructure when done:

```bash
terraform destroy
```

## Notes

- The EC2 instance uses `t2.micro`, which is AWS Free Tier eligible.
- `terraform.tfvars` is ignored by Git to avoid committing sensitive values.
- When `public_key_path` is set, `bootscript.sh` injects the local public key into `/home/ubuntu/.ssh/authorized_keys` so you can SSH without an AWS-managed key pair.
- Opening SSH (`22`) to `0.0.0.0/0` is acceptable for a learning challenge but should be restricted to your IP in production. Use `allowed_ssh_cidr` to tighten this.
