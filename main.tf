provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

module "iam_role" {
  source                 = "./modules/iam_role"
  role_name              = "${var.role_name}_byTF"
  assume_role_policy     = data.aws_iam_policy_document.assume_role_policy.json
  permissions_boundary   = var.permissions_boundary
}

module "iam_policy" {
  source       = "./modules/iam_policy"
  policy_name  = "${var.policy_name}_byTF"
  description  = var.policy_description
  policy_json  = data.aws_iam_policy_document.policy.json
}

module "lambda_function" {
  source        = "./modules/lambda_function"
  function_name = "${var.lambda_function_name}_byTF"
  role          = module.iam_role.role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  source_code   = "fileb://function.zip"
}

resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = module.iam_role.role_name
  policy_arn = module.iam_policy.policy_arn
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:CreateBucket",
      "s3:DeleteBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
      "lambda:CreateFunction",
      "lambda:InvokeFunction",
      "lambda:DeleteFunction",
      "lambda:GetFunctionConfiguration",
      "lambda:UpdateFunctionConfiguration",
      "lambda:GetFunction",
      "lambda:ListVersionsByFunction"
    ]
    resources = ["*"]
  }
}