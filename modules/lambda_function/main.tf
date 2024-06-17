resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  runtime       = var.runtime

  filename      = var.filename

  source_code_hash = filebase64sha256(var.filename)

  environment {
    variables = {
      AWS_REGION = var.aws_region
    }
  }

  tags = var.tags
}

output "function_name" {
  value = aws_lambda_function.this.function_name
}

output "function_arn" {
  value = aws_lambda_function.this.arn
}