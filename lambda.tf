data "archive_file" "reviews_lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_src/lambda_function.py"
  output_path = "${path.module}/function.zip"
}

resource "aws_lambda_function" "reviews" {
  function_name    = "${var.project_name}-reviews-handler"
  role             = aws_iam_role.reviews_lambda.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 10
  memory_size      = 128
  filename         = data.archive_file.reviews_lambda.output_path
  source_code_hash = data.archive_file.reviews_lambda.output_base64sha256

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.reviews.name
    }
  }
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "apigateway-invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.reviews.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.reviews.execution_arn}/*/*"
}
