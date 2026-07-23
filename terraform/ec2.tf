resource "aws_instance" "k3s_node" {
  count = var.node_count

  ami                         = var.ubuntu_ami_id != null ? var.ubuntu_ami_id : data.aws_ami.ubuntu[0].id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.k3s_node_access.id]
  associate_public_ip_address = true
  user_data_replace_on_change = true

  # Reserved for future k3s, ingress, and application bootstrap commands.
  user_data = <<-EOF
    #!/bin/bash
    set -euxo pipefail

    # Future k3s installation commands belong here.
  EOF

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.volume_size
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name      = var.node_count == 1 ? var.instance_name : "${var.instance_name}-${count.index + 1}"
    Role      = "k3s-node"
    NodeIndex = tostring(count.index + 1)
  }
}
