output "instance_id" {
  description = "ID of the Turnos k3s development EC2 instance."
  value       = aws_instance.turnos.id
}

output "public_ip" {
  description = "Public IPv4 address used for SSH and future ingress access."
  value       = aws_instance.turnos.public_ip
}

output "private_ip" {
  description = "Private IPv4 address of the EC2 instance within the default VPC."
  value       = aws_instance.turnos.private_ip
}

output "default_vpc_id" {
  description = "Default VPC reused by this sandbox deployment."
  value       = data.aws_vpc.default.id
}

output "default_subnet_id" {
  description = "Default subnet selected for the EC2 instance."
  value       = data.aws_subnet.default.id
}
