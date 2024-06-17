variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The assume role policy JSON"
  type        = string
}

variable "permissions_boundary" {
  description = "The ARN of the permissions boundary policy"
  type        = string
}