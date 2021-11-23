resource "aws_networkfirewall_firewall" "example" {
  name                = var.firewall["name"]
  description         = var.firewall["description"]
  delete_protection   = var.firewall["delete_protection"]
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
  vpc_id              = aws_vpc.example.id

  subnet_change_protection = var.firewall["subnet_change_protection"]

  subnet_mapping {
    subnet_id = aws_subnet.example.id
  }

}

variable "firewall" {
  type = object({
    name                     = string
    description              = string
    delete_protection        = bool
    subnet_change_protection = bool
  })

  default = {
    name              = "example"
    description       = "a firewall"
    delete_protection = false //defaults to false


    subnet_change_protection = false //defaults to false
  }
}