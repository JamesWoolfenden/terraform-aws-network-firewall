resource "aws_networkfirewall_logging_configuration" "example" {
  firewall_arn = aws_networkfirewall_firewall.example.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        bucketName = aws_s3_bucket.firewall_logs.bucket
        prefix     = "/example"
      }
      log_destination_type = "S3"
      log_type             = "FLOW"
    }
  }
}
