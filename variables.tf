variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "The AWS profile to use."
  type        = string
  default     = "DevOpsAccessRole"
}

variable "dev_team_role_name" {
  description = "The name of the Dev Team role"
  type        = string
  default     = "DevTeamRole_byTF"
}

variable "dev_team_full_access_policy_name" {
  description = "The name of the Dev Team full access policy"
  type        = string
  default     = "DevTeamFullAccessPolicy_byTF"
}

variable "iam_role_and_policy_management_policy_name" {
  description = "The name of the IAM role and policy management policy"
  type        = string
  default     = "IAMRoleAndPolicyManagement_byTF"
}

variable "permissions_boundary" {
  description = "The ARN of the permissions boundary policy"
  type        = string
  default     = "arn:aws:iam::654654554758:policy/eo_role_boundary"
}
