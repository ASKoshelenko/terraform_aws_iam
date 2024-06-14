resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  permissions_boundary = var.permissions_boundary
}

output "role_name" {
  value = aws_iam_role.this.name
}
