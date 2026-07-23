# PPAM k3s Development Platform

Terraform configuration for a low-cost AWS Academy sandbox environment. It reuses the account's default VPC and one of its default public subnets, then creates one Ubuntu EC2 instance suitable for a future single-node k3s cluster.

## Architecture

- Default VPC and default public subnet (existing AWS Academy resources)
- One `t3.medium` EC2 instance running Ubuntu
- Encrypted `gp3` root volume
- Security group allowing SSH from a configurable CIDR and public HTTP/HTTPS for future NGINX Ingress
- No EKS, load balancers, NAT gateways, RDS, or other costly managed infrastructure

## Prerequisites

- Terraform 1.5 or later
- AWS CLI credentials for the active AWS Academy sandbox session
- An existing EC2 key pair in the selected AWS Region
- A default VPC and default subnet in the selected AWS Region

## Configuration

1. Copy the example variables file:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars`:

   - Set `ssh_allowed_cidr` to your current public IP address with `/32` suffix.
   - Set `key_pair_name` to the name of an EC2 key pair that already exists in the selected Region.
   - Optionally set `ubuntu_ami_id` to pin a specific regional Ubuntu AMI. If omitted, the latest Canonical Ubuntu 22.04 LTS image is selected.
   - Keep `node_count = 1` for the current environment. Increase it later to create up to three identically configured k3s nodes.

Do not commit `terraform.tfvars`, AWS credentials, private keys, or Terraform state.

## Workflow

Run all commands from this project directory:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
```

After `terraform apply`, use the `public_ip` output for SSH. Always run `terraform destroy` when finished; AWS Academy sandbox resources are temporary and may be reset automatically.

## Future Extensions

The EC2 `user_data` block is reserved for k3s bootstrap automation. This layout can later be extended with an instance IAM role, ECR repositories, GitHub Actions deployment, Kubernetes manifests, and Helm charts without changing the existing network foundation.
