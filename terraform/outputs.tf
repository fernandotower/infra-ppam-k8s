output "instance_id" {
  description = "ID of the PPAM k3s development EC2 instance."
  value       = aws_instance.k3s_node[0].id
}

output "public_ip" {
  description = "Public IPv4 address used for SSH and future ingress access."
  value       = aws_instance.k3s_node[0].public_ip
}

output "private_ip" {
  description = "Private IPv4 address of the EC2 instance within the default VPC."
  value       = aws_instance.k3s_node[0].private_ip
}

output "k3s_nodes" {
  description = "Details for every k3s node; useful after increasing node_count."
  value = {
    for index, node in aws_instance.k3s_node : "node-${index + 1}" => {
      id         = node.id
      public_ip  = node.public_ip
      private_ip = node.private_ip
    }
  }
}

output "default_vpc_id" {
  description = "Default VPC reused by this sandbox deployment."
  value       = data.aws_vpc.default.id
}

output "default_subnet_id" {
  description = "Default subnet selected for the EC2 instance."
  value       = data.aws_subnet.default.id
}
