variable "aws_region" {
  description = "AWS region where the development platform is deployed."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name used in resource tags."
  type        = string
  default     = "dev"

  validation {
    condition     = length(trimspace(var.environment)) > 0
    error_message = "environment must not be empty."
  }
}

variable "project_name" {
  description = "Project name used to name and tag resources."
  type        = string
  default     = "turnos"

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name must not be empty."
  }
}

variable "instance_type" {
  description = "EC2 instance type. AWS Academy sandbox accounts support up to t3.medium."
  type        = string
  default     = "t3.medium"

  validation {
    condition     = var.instance_type == "t3.medium" || can(regex("^t3\\.(nano|micro|small)$", var.instance_type))
    error_message = "instance_type must be t3.medium or a smaller t3 instance type for the AWS Academy sandbox."
  }
}

variable "instance_name" {
  description = "Name tag assigned to the EC2 instance."
  type        = string
  default     = "turnos-k3s-dev"
}

variable "volume_size" {
  description = "Root EBS volume size in GiB."
  type        = number
  default     = 20

  validation {
    condition     = var.volume_size >= 8 && var.volume_size <= 100
    error_message = "volume_size must be between 8 and 100 GiB."
  }
}

variable "ssh_allowed_cidr" {
  description = "IPv4 CIDR range allowed to connect to the instance over SSH. Set this to your public IP, for example 203.0.113.10/32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_allowed_cidr))
    error_message = "ssh_allowed_cidr must be a valid IPv4 CIDR block."
  }
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name for SSH access."
  type        = string

  validation {
    condition     = length(trimspace(var.key_pair_name)) > 0
    error_message = "key_pair_name must not be empty."
  }
}

variable "ubuntu_ami_id" {
  description = "Optional Ubuntu AMI ID. When null, Terraform selects the latest Ubuntu 22.04 LTS AMI published by Canonical."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.ubuntu_ami_id == null || can(regex("^ami-[0-9a-f]+$", var.ubuntu_ami_id))
    error_message = "ubuntu_ami_id must be a valid AMI ID such as ami-0123456789abcdef0, or null."
  }
}
