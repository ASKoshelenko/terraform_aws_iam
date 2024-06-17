variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "The AWS profile to use."
  type        = string
  default     = "assume-role-profile"
}

variable "lambda_role_name" {
  description = "The name of the Lambda IAM role"
  type        = string
  default     = "3TaskLambda"
}

variable "lambda_policy_name" {
  description = "The name of the Lambda IAM policy"
  type        = string
  default     = "3Task_S3ManagementPolicy"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "S3OperationsFunction"
}

variable "lambda_deployment_package" {
  description = "The filename of the Lambda deployment package"
  type        = string
  default     = "function.zip"
}

variable "lambda_tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}