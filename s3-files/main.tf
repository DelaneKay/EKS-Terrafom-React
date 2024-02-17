resource "aws_s3_bucket" "kubernetes-remote-backend" {
  bucket = "kubernetes-remote-backend"
  force_destroy = true 
}

resource "aws_s3_bucket_versioning" "bucket-versioning" {
  bucket = "kubernetes-remote-backend"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket-encrypt" {
  bucket = "kubernetes-remote-backend"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}