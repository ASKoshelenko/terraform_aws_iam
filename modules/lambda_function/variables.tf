variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "role" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "handler" {
  description = "The handler for the Lambda function"
  type        = string
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  type        = string
}

variable "source_code" {
  description = "The path to the ZIP file containing the Lambda function code"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}
