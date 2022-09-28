module "firewall" {
  source  = "../../"
  vpc_id  = "vpc-0e204c74343e44b95"
  subnets = ["subnet-0fe60b8a890561d2d"]
  rule_group = {
    capacity = 100
    name     = "pike"
    type     = "STATEFUL"
  }
  kms_key = aws_kms_key.example
  source_list = [{
    generated_rules_type = "DENYLIST"
    target_types         = ["HTTP_HOST"]
    targets              = ["test.pike.com"]
  }]

  log_destination = {
    bucketName           = module.firewall.bucketName
    log_destination_type = "S3"
    log_type             = "FLOW"
    prefix               = "/example"
  }
  tags = var.common_tags
}
