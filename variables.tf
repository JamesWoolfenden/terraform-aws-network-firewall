
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

variable "subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "kms_key" {}

variable "tags" {
  type = map(any)
}


variable "rule_group" {
  type = object({
    capacity = number
    name     = string
    type     = string
  })
}

variable "source_list" {
  type = list(object({
    generated_rules_type = string
    target_types         = list(string)
    targets              = list(string)
  }))

}
