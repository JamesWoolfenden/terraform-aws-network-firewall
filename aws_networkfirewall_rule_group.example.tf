resource "aws_networkfirewall_rule_group" "example" {
  capacity = var.rule_group.capacity
  name     = var.rule_group.name
  type     = var.rule_group.type
  rule_group {
    rules_source {
      dynamic "rules_source_list" {
        for_each = var.source_list
        content {
          generated_rules_type = rules_source_list.value.generated_rules_type
          target_types         = rules_source_list.value.target_types
          targets              = rules_source_list.value.targets
        }
      }
    }
  }
  tags = var.tags
}
