resource "aws_security_group" "k3s_node_access" {
  name_prefix = "${local.name_prefix}-k3s-"
  description = "Network access for the PPAM k3s development instance"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from the configured administrator network"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_allowed_cidr]
  }

  ingress {
    description = "HTTP for future NGINX Ingress traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS for future NGINX Ingress traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound internet access for package installation and containers"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-k3s-sg"
  }
}
