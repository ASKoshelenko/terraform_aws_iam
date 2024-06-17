variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-central-1"
}

variable "aws_access_key" {
  description = "The AWS access key to use."
  type        = string
}

variable "aws_secret_key" {
  description = "The AWS secret key to use."
  type        = string
}

variable "aws_session_token" {
  description = "The AWS session token to use."
  type        = string
}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "3TaskLambda"
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
  default     = "3Task_S3ManagementPolicy"
}

variable "policy_description" {
  description = "The description of the IAM policy"
  type        = string
  default     = "Policy for managing S3 and Lambda functions"
}

variable "permissions_boundary" {
  description = "The ARN of the permissions boundary policy"
  type        = string
  default     = "arn:aws:iam::654654554758:policy/eo_role_boundary"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = "S3OperationsFunction"
}