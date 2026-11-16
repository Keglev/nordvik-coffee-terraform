output "website_url" {
  description = "Custom domain URL with HTTPS"
  value       = "https://${var.domain_name}"
}

output "cloudfront_url" {
  description = "CloudFront distribution URL"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "s3_bucket_url" {
  description = "Direct S3 bucket URL (not publicly accessible)"
  value       = "s3://${aws_s3_bucket.site.id}"
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

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (for cache invalidation)"
  value       = aws_cloudfront_distribution.site.id
}
