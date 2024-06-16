provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "dev_team_role" {
  source                 = "./modules/iam_role"
  role_name              = var.dev_team_role_name
  assume_role_policy     = data.aws_iam_policy_document.assume_role_policy.json
  permissions_boundary   = var.permissions_boundary
}

module "dev_team_full_access_policy" {
  source       = "./modules/iam_policy"
  policy_name  = var.dev_team_full_access_policy_name
  description  = "Full access policy for the Dev Team role"
  policy_json  = data.aws_iam_policy_document.dev_team_full_access_policy.json
}

module "iam_role_and_policy_management_policy" {
  source       = "./modules/iam_policy"
  policy_name  = var.iam_role_and_policy_management_policy_name
  description  = "Policy to manage IAM roles and policies"
  policy_json  = data.aws_iam_policy_document.iam_role_and_policy_management_policy.json
}

resource "aws_iam_role_policy_attachment" "dev_team_role_attach" {
  role       = module.dev_team_role.role_name
  policy_arn = module.dev_team_full_access_policy.policy_arn
}

resource "aws_iam_role_policy_attachment" "iam_role_attach" {
  role       = module.dev_team_role.role_name
  policy_arn = module.iam_role_and_policy_management_policy.policy_arn
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::654654554758:root"]
    }
    condition {
      test     = "StringLike"
      variable = "aws:userid"
      values   = ["*:Bohdan_Syniuk@epam.com", "*:oleksii_koshelenko@epam.com"]
    }
  }
}

data "aws_iam_policy_document" "dev_team_full_access_policy" {
  statement {
    actions = [
      "cloudwatch:*",
      "ssm:*",
      "dynamodb:*",
      "s3:*",
      "cognito-identity:*",
      "cognito-idp:*",
      "ec2:*",
      "cloudformation:*",
      "sqs:*",
      "sns:*",
      "xray:*",
      "states:*",
      "support:*",
      "workspaces:*",
      "securityhub:DescribeHub",
      "guardduty:*",
      "apigateway:*",
      "firehose:*",
      "events:*",
      "lambda:*",
      "cloudtrail:*",
      "ecr:*",
      "servicecatalog:ListApplications"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["eu-central-1"]
    }
  }

  statement {
    actions = [
      "ec2:Describe*",
      "ssm:Describe*",
      "dynamodb:Describe*",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "lambda:ListFunctions"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values   = ["us-east-1"]
    }
  }

  statement {
    actions = ["tag:GetResources"]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:tagKeys"
      values   = ["environment", "project", "owner", "application", "system_protected"]
    }
  }

  statement {
    actions = ["tag:TagResources", "tag:UntagResources"]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:tagKeys"
      values   = ["environment", "project", "owner", "application", "system_protected"]
    }
  }

  statement {
    actions = [
      "ec2:Describe*",
      "ssm:Describe*",
      "dynamodb:Describe*",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "lambda:ListFunctions"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "aws:RequestTag/Name"
      values   = ["*pesc-*", "*pesc_*", "*-prod*", "*-cicd*"]
    }
  }

  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::654654554758:role/DevTeamRole_byTF"]
  }
}

data "aws_iam_policy_document" "iam_role_and_policy_management_policy" {
  statement {
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:UpdateAssumeRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:GetAccountSummary",
      "iam:ListAccountAliases",
      "iam:GetPolicy",
      "iam:ListRoles",
      "iam:ListGroups",
      "iam:ListUsers",
      "iam:ListPolicies",
      "iam:ListOpenIDConnectProviders",
      "iam:ListSAMLProviders",
      "iam:ListSTSRegionalEndpointsStatus",
      "ce:GetCostAndUsage",
      "ce:GetCostForecast",
      "ce:GetAnomalies",
      "budgets:ViewBudget",
      "cost-optimization-hub:ListEnrollmentStatuses",
      "cost-optimization-hub:ListRecommendationSummaries"
    ]
    resources = ["*"]
  }

  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::654654554758:role/DevTeamRole_byTF"]
  }
}
