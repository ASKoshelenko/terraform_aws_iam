provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "lambda_role" {
  source    = "./modules/iam_role"
  role_name = var.lambda_role_name
}

module "lambda_policy" {
  source    = "./modules/iam_policy"
  policy_name = var.lambda_policy_name
  role_arn    = module.lambda_role.role_arn
}

module "s3_operations_lambda" {
  source        = "./modules/lambda_function"
  function_name = var.lambda_function_name
  role_arn      = module.lambda_role.role_arn
  filename      = var.lambda_deployment_package
  aws_region    = var.aws_region
  tags          = var.lambda_tags
}