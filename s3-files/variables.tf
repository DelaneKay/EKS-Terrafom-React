variable "bucket_name" {
  default = "kubernetes-remote-backend"
}

variable "dynamodb_name" {
  default = "kubernetes-terraform-locking"
}

variable "region" {
  default = "us-east-1"
}