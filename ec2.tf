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

resource "aws_instance" "turnos" {
  ami                         = var.ubuntu_ami_id != null ? var.ubuntu_ami_id : data.aws_ami.ubuntu[0].id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.turnos.id]
  associate_public_ip_address = true
  user_data_replace_on_change = true

  # Reserved for future k3s, ingress, and application bootstrap commands.
  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    # Future k3s installation commands belong here.
  EOF

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.volume_size
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
    Role = "k3s-node"
  }
}
