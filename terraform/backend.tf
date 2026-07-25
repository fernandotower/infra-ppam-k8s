terraform {
  backend "s3" {
    bucket  = "ppam-terraform-state"
    key     = "ppam/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
