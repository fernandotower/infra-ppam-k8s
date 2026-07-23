# AWS Academy sandbox accounts normally include a default VPC and public subnets.
# Reusing them avoids creating billable networking resources such as NAT gateways.
data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Select a default subnet in the first available Availability Zone. Default subnets
# assign public IPv4 addresses when the instance requests one.
data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  default_for_az    = true
}
