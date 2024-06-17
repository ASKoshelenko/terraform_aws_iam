variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role"
  type        = string
}

variable "handler" {
  description = "The function handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "runtime" {
  description = "The runtime environment"
  type        = string
  default     = "python3.8"
}

variable "filename" {
  description = "The filename of the Lambda deployment package"
  type        = string
  default     = "function.zip"
}

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}