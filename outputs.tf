output "policy_dev_team_arn" {
  value = module.dev_team_full_access_policy.policy_arn
}

output "policy_iam_management_arn" {
  value = module.iam_role_and_policy_management_policy.policy_arn
}

output "role_arn" {
  value = module.dev_team_role.role_name
}
