resource "aws_lambda_function" "this" {
  function_name = var.function_name
  role          = var.role
  handler       = var.handler
  runtime       = var.runtime
  filename      = "${path.root}/function.zip"
}

output "lambda_function_arn" {
  value = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  value = aws_lambda_function.this.function_name
}