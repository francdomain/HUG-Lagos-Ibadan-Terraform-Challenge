# HUG Lagos/Ibadan Terraform Challenge — Week Two

A refactored, modular Terraform project that provisions an Nginx web server on AWS inside a custom VPC.

This project breaks the Week One infrastructure into reusable modules (VPC, Networking, Security Groups, Compute) and stores Terraform state in a remote S3 backend with DynamoDB locking.

## Architecture

- **VPC** (`10.0.0.0/16`)
- **Public Subnet** (`10.0.1.0/24`) with automatic public IP assignment
- **Internet Gateway** for outbound/inbound internet access
- **Route Table** routing `0.0.0.0/0` to the Internet Gateway
- **Security Group** allowing:
  - SSH (`22`) from a configurable CIDR
  - HTTP (`80`) from anywhere
- **EC2 Instance** (Ubuntu 22.04 LTS, `t2.micro`) bootstrapped with `user_data` to install Nginx and serve a simple HTML page.
- **Remote state backend** (`backend/`): S3 bucket for state storage and DynamoDB table for state locking.

## Modules

| Module | Path | Responsibility |
|---|---|---|
| `vpc` | `modules/vpc/` | Creates the VPC |
| `networking` | `modules/networking/` | Public subnet, internet gateway, route table and route table association |
| `security_group` | `modules/security_group/` | Security group with SSH/HTTP ingress and egress rule |
| `compute` | `modules/compute/` | AMI lookup, EC2 instance, user-data render and outputs |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.5.0`
- AWS credentials configured locally (e.g., via `aws configure` or environment variables)
- A local SSH public key file (optional, only needed if you want SSH access)

## Remote Backend Setup

The root project expects the S3 backend resources to exist before it can plan or apply.

1. **Deploy the backend resources:**

   ```bash
   cd backend
   terraform init
   terraform plan
   terraform apply
   ```

2. **Migrate the root project to the remote backend:**

   ```bash
   cd ..
   terraform init -migrate-state
   ```

   > If the S3 bucket name is already taken, change `bucket_name` in `backend/terraform.tfvars` and the matching `backend "s3"` block in `providers.tf` before applying.

## Quick Start

1. **Configure your deployment:**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

   Edit `terraform.tfvars` and replace `user_full_name` with your name.

2. **Format and validate:**

   ```bash
   terraform fmt -check -recursive
   terraform validate
   ```

3. **Review the execution plan:**

   ```bash
   terraform plan
   ```

4. **Apply the infrastructure:**

   ```bash
   terraform apply
   ```

5. **Access the web page:**

   After `apply` completes, open the URL shown in the `website_url` output:

   ```bash
   terraform output website_url
   ```

## Useful Commands

| Command | Purpose |
|---|---|
| `terraform fmt -recursive` | Format all Terraform files |
| `terraform validate` | Validate the configuration |
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

## Deliverables

- Modular Terraform code in `modules/`
- Remote backend configured in `backend/`
- Deployment instructions in this README
- Screenshot of the Nginx landing page
- Screenshot of the AWS EC2 console showing the running instance
- LinkedIn post explaining the implementation (`linkedin-post.md`)

## Cleanup

To avoid ongoing AWS charges, destroy the infrastructure when done:

```bash
terraform destroy
```

## Notes

- The EC2 instance uses `t2.micro`, which is AWS Free Tier eligible.
- `terraform.tfvars` is ignored by Git to avoid committing sensitive values.
- Opening SSH (`22`) to `0.0.0.0/0` is acceptable for a learning challenge but should be restricted to your IP in production. Use `allowed_ssh_cidr` to tighten this.
