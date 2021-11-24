resource "aws_s3_bucket" "firewall_logs" {

  # checkov:skip=CKV_AWS_18: Not appropriate
  # checkov:skip=CKV_AWS_144: Not appropriate
  # checkov:skip=CKV_AWS_21: Not appropriate
  bucket = "firewall_logs_${data.aws_caller_identity.current.account_id}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.firewall_logs.id
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
}
