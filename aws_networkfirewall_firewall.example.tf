resource "aws_networkfirewall_firewall" "example" {
  name                = var.firewall["name"]
  description         = var.firewall["description"]
  delete_protection   = var.firewall["delete_protection"]
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
  vpc_id              = var.vpc_id

  subnet_change_protection = var.firewall["subnet_change_protection"]

  dynamic "subnet_mapping" {
    for_each = var.subnets
    content {
      subnet_id = subnet_mapping.value
    }
  }

}
