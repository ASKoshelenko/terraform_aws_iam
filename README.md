
# Terraform AWS IAM and Lambda Setup

This repository contains Terraform configurations to set up IAM roles, policies, and a Lambda function on AWS. The configuration also includes setting up SQS queues and necessary permissions for the Lambda function to interact with SQS and S3.

## Project Structure

```plaintext
.
├── Task3.zip
├── main.tf
├── modules
│   ├── iam_policy
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── iam_role
│   │   ├── main.tf
│   │   └── variables.tf
│   └── lambda_function
│       ├── function.zip
│       ├── lambda_function.py
│       ├── main.tf
│       └── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```

## Prerequisites

- Terraform installed on your local machine.
- AWS credentials configured in `~/.aws/credentials`.

## Setup

1. Clone the repository:

    ```bash
    git clone https://github.com/ASKoshelenko/terraform_aws_iam.git
    cd terraform_aws_iam
    ```

2. Initialize Terraform:

    ```bash
    terraform init
    ```

3. Plan the changes:

    ```bash
    terraform plan
    ```

4. Apply the changes:

    ```bash
    terraform apply
    ```
