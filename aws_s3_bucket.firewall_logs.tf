resource "aws_s3_bucket" "firewall_logs" {
  # checkov:skip=CKV_AWS_18: Not appropriate
  # checkov:skip=CKV_AWS_144: Not appropriate
  # checkov:skip=CKV_AWS_21: Not appropriate
  # checkov:skip=CKV2_AWS_37: no versioning req
  # checkov:skip=CKV2_AWS_41: no logging req
  # checkov:skip=CKV_AWS_145:v4 legacy
  # checkov:skip=CKV_AWS_19:v4 legacy

  bucket = "firewall_logs_${data.aws_caller_identity.current.account_id}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "firewall_logs" {
  bucket = aws_s3_bucket.firewall_logs.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key.arn
      sse_algorithm     = "aws:kms"
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
