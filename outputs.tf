output "website_url" {
  description = "Public URL of the S3 static website"
  value       = "http://${aws_s3_bucket_website_configuration.site.website_endpoint}"
}

output "api_endpoint" {
  description = "Base invoke URL of the reviews API"
  value       = local.reviews_api_url
}

output "bucket_name" {
  description = "Name of the S3 bucket hosting the site"
  value       = aws_s3_bucket.site.id
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table storing reviews"
  value       = aws_dynamodb_table.reviews.name
}

output "lambda_function_name" {
  description = "Name of the reviews Lambda function"
  value       = aws_lambda_function.reviews.function_name
}
