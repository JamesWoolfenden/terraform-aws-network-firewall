variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map(any)
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

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "kms_key" {}
