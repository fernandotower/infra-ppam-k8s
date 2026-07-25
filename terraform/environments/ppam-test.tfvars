# Copy to terraform.tfvars and replace placeholder values before applying.
aws_region       = "us-east-1"
environment      = "test"
project_name     = "turnos"
instance_type    = "t3.medium"
instance_name    = "turnos-k3s-test"
volume_size      = 20
ssh_allowed_cidr = "203.0.113.10/32"
key_pair_name    = "replace-with-your-existing-key-pair"

# Optional: set a regional Ubuntu AMI ID to pin the image version.
# ubuntu_ami_id = "ami-0123456789abcdef0"
