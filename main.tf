provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

data "aws_caller_identity" "current" {}

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
  policy_json  = data.aws_iam_policy_document.policy_with_ip_restriction.json
}

module "lambda_function" {
  source        = "./modules/lambda_function"
  function_name = "${var.lambda_function_name}_byTF"
  role          = module.iam_role.role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  source_code   = "fileb://function.zip"
  environment_variables = {
    "ENV_VAR1" = "value1"
    "ENV_VAR2" = "value2"
  }
}

resource "aws_iam_role_policy_attachment" "role_attach" {
  role       = module.iam_role.role_name
  policy_arn = module.iam_policy.policy_arn
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "${var.policy_name}_sqs_byTF"
  description = "Policy to allow Lambda to send messages to SQS"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage"
        ]
        Resource = [
          aws_sqs_queue.lambda_success.arn,
          aws_sqs_queue.lambda_failure.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sqs_policy_attach" {
  role       = module.iam_role.role_name
  policy_arn = aws_iam_policy.sqs_policy.arn
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

data "aws_iam_policy_document" "policy_with_ip_restriction" {
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
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = [var.allowed_ip]
    }
  }
}

resource "aws_sqs_queue" "lambda_success" {
  name = "lambda-success"
}

resource "aws_sqs_queue" "lambda_failure" {
  name = "lambda-failure"
}

resource "aws_lambda_function_event_invoke_config" "test_event_config" {
  function_name                   = module.lambda_function.lambda_function_name
  maximum_retry_attempts          = 2
  qualifier                       = "$LATEST"
  destination_config {
    on_success {
      destination = aws_sqs_queue.lambda_success.arn
    }
    on_failure {
      destination = aws_sqs_queue.lambda_failure.arn
    }
  }
}
