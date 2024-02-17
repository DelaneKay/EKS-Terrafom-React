provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "kubernetes-remote-backend"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "kubernetes-terraform-locking"
    encrypt = true
  }
}