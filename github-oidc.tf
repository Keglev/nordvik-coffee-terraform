# GitHub OIDC Provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ]

  tags = {
    Name        = "github-actions-oidc"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

# IAM Role that GitHub Actions will assume
resource "aws_iam_role" "github_actions" {
  name = "${var.project_name}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
            "token.actions.githubusercontent.com:sub" = "repo:TanjaNY/nordvik-coffee-terraform:ref:refs/heads/main"
          }
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-github-actions-role"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

# Attach policies to allow GitHub Actions to manage infrastructure
resource "aws_iam_role_policy" "github_actions_terraform" {
  name = "${var.project_name}-github-terraform-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          # S3 permissions
          "s3:*",
          # DynamoDB permissions
          "dynamodb:*",
          # Lambda permissions
          "lambda:*",
          # API Gateway permissions
          "apigateway:*",
          # IAM permissions (limited)
          "iam:GetRole",
          "iam:GetRolePolicy",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListPolicyVersions",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PassRole",
          "iam:TagRole",
          "iam:UntagRole",
          # OIDC Provider permissions
          "iam:GetOpenIDConnectProvider",
          "iam:ListOpenIDConnectProviders",
          "iam:CreateOpenIDConnectProvider",
          "iam:DeleteOpenIDConnectProvider",
          "iam:TagOpenIDConnectProvider",
          "iam:UntagOpenIDConnectProvider",
          # CloudWatch Logs
          "logs:*",
          # Budgets
          "budgets:*",
          # Route53
          "route53:*",
          # ACM
          "acm:*",
          # CloudFront
          "cloudfront:*",
          # WAF
          "wafv2:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Output the role ARN for GitHub Actions configuration
output "github_actions_role_arn" {
  description = "IAM Role ARN for GitHub Actions to assume"
  value       = aws_iam_role.github_actions.arn
}
