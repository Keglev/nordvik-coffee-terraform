variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Prefix used for naming all resources"
  type        = string
  default     = "nordvik-coffee"
}
