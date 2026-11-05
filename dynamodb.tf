resource "aws_dynamodb_table" "reviews" {
  name         = "${var.project_name}-reviews"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "reviewId"

  attribute {
    name = "reviewId"
    type = "S"
  }

  # Enable Point-in-Time Recovery for automated backups
  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Name        = "${var.project_name}-reviews"
    Environment = "production"
    ManagedBy   = "Terraform"
    Backup      = "enabled"
  }
}
