output "lambda_function_arn" {
  value = module.lambda_function.lambda_function_arn
}

output "lambda_function_name" {
  value = module.lambda_function.lambda_function_name
}

output "sqs_success_queue_url" {
  value = aws_sqs_queue.lambda_success.id
}

output "sqs_failure_queue_url" {
  value = aws_sqs_queue.lambda_failure.id
}

output "sqs_success_queue_arn" {
  value = aws_sqs_queue.lambda_success.arn
}

output "sqs_failure_queue_arn" {
  value = aws_sqs_queue.lambda_failure.arn
}
