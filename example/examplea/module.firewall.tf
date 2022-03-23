module "firewall" {
  source      = "../../"
  vpc_id      = "vpc-0e204c74343e44b95"
  subnet_id   = "subnet-0fe60b8a890561d2d"
  kms_key     = aws_kms_key.example
  common_tags = var.common_tags
}
