variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "path" {
  description = "The path for the IAM policy"
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the IAM policy"
  type        = string
}

variable "policy_json" {
  description = "The JSON of the IAM policy"
  type        = string
}
