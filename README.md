# terraform-aws-network-firewall

[![Build Status](https://github.com/JamesWoolfenden/terraform-aws-network-firewall/workflows/Verify%20and%20Bump/badge.svg?branch=main)](https://github.com/JamesWoolfenden/terraform-aws-network-firewall)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-aws-network-firewall.svg)](https://github.com/JamesWoolfenden/terraform-aws-network-firewall/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-aws-network-firewall.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-aws-network-firewall/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D0.14.0-blue.svg)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/JamesWoolfenden/terraform-aws-network-firewall/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-network-firewall&benchmark=CIS+AWS+V1.2)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/jameswoolfenden/terraform-aws-network-firewall/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=JamesWoolfenden%2Fterraform-aws-network-firewall&benchmark=INFRASTRUCTURE+SECURITY)

Terraform module -

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

This is just a very basic example.

```cli
$ checkov -d . --external-checks-dir checkov/
...
```

![alt text](./diagram/network-firewall.png)

Include **module.network-firewall.tf** this repository as a module in your existing terraform code:

```terraform
module "network-firewall" {
  source        = "JamesWoolfenden/network-firewall/aws"
  version       = "0.0.1"
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
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_networkfirewall_firewall.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall) | resource |
| [aws_networkfirewall_firewall_policy.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_logging_configuration.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_logging_configuration) | resource |
| [aws_networkfirewall_rule_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |
| [aws_s3_bucket.firewall_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.firewall_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_firewall"></a> [firewall](#input\_firewall) | n/a | <pre>object({<br>    name                     = string<br>    description              = string<br>    delete_protection        = bool<br>    subnet_change_protection = bool<br>  })</pre> | <pre>{<br>  "delete_protection": false,<br>  "description": "a firewall",<br>  "name": "example",<br>  "subnet_change_protection": false<br>}</pre> | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | n/a | `any` | n/a | yes |
| <a name="input_log_destination"></a> [log\_destination](#input\_log\_destination) | n/a | <pre>object({<br>    bucketName           = string<br>    prefix               = string<br>    log_destination_type = string<br>    log_type             = string<br>  })</pre> | n/a | yes |
| <a name="input_rule_group"></a> [rule\_group](#input\_rule\_group) | n/a | <pre>object({<br>    capacity = number<br>    name     = string<br>    type     = string<br>  })</pre> | n/a | yes |
| <a name="input_source_list"></a> [source\_list](#input\_source\_list) | n/a | <pre>list(object({<br>    generated_rules_type = string<br>    target_types         = list(string)<br>    targets              = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(any)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucketName"></a> [bucketName](#output\_bucketName) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Policy

This is the policy required to build this project:

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
resource "aws_iam_policy" "terraform_pike" {
  name_prefix = "terraform_pike"
  path        = "/"
  description = "Pike Autogenerated policy from IAC"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:CreateVpcEndpoint",
                "ec2:DeleteVpcEndpoints",
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeRouteTables",
                "ec2:DescribeSubnets",
                "ec2:DescribeVpcEndpoints",
                "ec2:DescribeVpcs"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogDelivery",
                "logs:DeleteLogDelivery",
                "logs:GetLogDelivery",
                "logs:ListLogDeliveries"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor3",
            "Effect": "Allow",
            "Action": [
                "network-firewall:AssociateFirewallPolicy",
                "network-firewall:CreateFirewall",
                "network-firewall:CreateFirewallPolicy",
                "network-firewall:CreateRuleGroup",
                "network-firewall:DeleteFirewall",
                "network-firewall:DeleteFirewallPolicy",
                "network-firewall:DeleteRuleGroup",
                "network-firewall:DescribeFirewall",
                "network-firewall:DescribeFirewallPolicy",
                "network-firewall:DescribeLoggingConfiguration",
                "network-firewall:DescribeRuleGroup",
                "network-firewall:ListRuleGroups",
                "network-firewall:TagResource",
                "network-firewall:UntagResource",
                "network-firewall:UpdateFirewallDeleteProtection",
                "network-firewall:UpdateFirewallDescription",
                "network-firewall:UpdateFirewallPolicy",
                "network-firewall:UpdateLoggingConfiguration",
                "network-firewall:UpdateRuleGroup",
                "network-firewall:UpdateSubnetChangeProtection"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor4",
            "Effect": "Allow",
            "Action": [
                "s3:CreateBucket",
                "s3:DeleteBucket",
                "s3:GetAccelerateConfiguration",
                "s3:GetBucketAcl",
                "s3:GetBucketCORS",
                "s3:GetBucketLogging",
                "s3:GetBucketObjectLockConfiguration",
                "s3:GetBucketPolicy",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketRequestPayment",
                "s3:GetBucketTagging",
                "s3:GetBucketVersioning",
                "s3:GetBucketWebsite",
                "s3:GetEncryptionConfiguration",
                "s3:GetLifecycleConfiguration",
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:GetReplicationConfiguration",
                "s3:ListBucket",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutEncryptionConfiguration"
            ],
            "Resource": "*"
        }
    ]
})
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-aws-network-firewall/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-aws-network-firewall/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2021-2022 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
