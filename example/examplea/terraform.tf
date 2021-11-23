terraform {
  required_providers {
    aws = {
      version = "3.66.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 0.14.8"
}
