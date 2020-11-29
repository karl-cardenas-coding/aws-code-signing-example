variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region where the Packer instance wil be launched"
}

variable "role_arn" {
  type        = string
  description = "The role arn for the AWS Role to assume"
}

variable "code-bucket" {
  type        = string
  description = "S3 Bucket to store the signed code"
}

variable "lambda-name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "lambda-role" {
  type        = string
  description = "The IAM role that will be attached to the Lambda function"
}