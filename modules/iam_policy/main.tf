resource "aws_iam_role_policy" "this" {
  name   = var.policy_name
  role   = var.role_arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:CreateBucket",
          "s3:DeleteBucket",
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "lambda:CreateFunction",
          "lambda:InvokeFunction",
          "lambda:DeleteFunction",
          "lambda:GetFunctionConfiguration",
          "lambda:UpdateFunctionConfiguration",
          "lambda:GetFunction",
          "lambda:ListVersionsByFunction"
        ]
        Resource = "*"
      }
    ]
  })
}

output "policy_arn" {
  value = aws_iam_role_policy.this.id
}