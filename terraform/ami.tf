# Used only when ubuntu_ami_id is not supplied. Pin ubuntu_ami_id in terraform.tfvars
# if reproducibility is more important than automatically receiving the latest image.
data "aws_ami" "ubuntu" {
  count       = var.ubuntu_ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
