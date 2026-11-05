data "aws_iam_policy_document" "lambda_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "reviews_lambda" {
  name               = "${var.project_name}-reviews-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust.json
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.reviews_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "aws_iam_policy_document" "dynamodb_access" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:PutItem", "dynamodb:Scan"]
    resources = [aws_dynamodb_table.reviews.arn]
  }
}

resource "aws_iam_role_policy" "dynamodb_access" {
  name   = "${var.project_name}-reviews-dynamodb-access"
  role   = aws_iam_role.reviews_lambda.id
  policy = data.aws_iam_policy_document.dynamodb_access.json
}
