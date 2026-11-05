resource "aws_apigatewayv2_api" "reviews" {
  name          = "${var.project_name}-reviews-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["http://${aws_s3_bucket_website_configuration.site.website_endpoint}"]
    allow_methods = ["GET", "POST", "OPTIONS"]
    allow_headers = ["content-type"]
  }
}

resource "aws_apigatewayv2_integration" "reviews_lambda" {
  api_id                 = aws_apigatewayv2_api.reviews.id
  integration_type       = "AWS_PROXY"
  integration_uri        = aws_lambda_function.reviews.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "default" {
  api_id    = aws_apigatewayv2_api.reviews.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.reviews_lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.reviews.id
  name        = "$default"
  auto_deploy = true
}
