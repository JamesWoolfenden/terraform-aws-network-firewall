resource "aws_networkfirewall_logging_configuration" "example" {
  firewall_arn = aws_networkfirewall_firewall.example.arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        bucketName = var.log_destination.bucketName
        prefix     = var.log_destination.prefix
      }
      log_destination_type = var.log_destination.log_destination_type
      log_type             = var.log_destination.log_type
    }
  }
}

variable "log_destination" {
  type = object({
    bucketName           = string
    prefix               = string
    log_destination_type = string
    log_type             = string
  })
}
