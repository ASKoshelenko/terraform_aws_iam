resource "aws_iam_policy" "this" {
  name        = var.policy_name
  description = var.description
  policy      = var.policy_json
}

output "policy_arn" {
  value = aws_iam_policy.this.arn
}
