#######################################
# Lambda Resources Option 1
#######################################
resource "aws_lambda_function" "test_lambda" {
  s3_bucket     = var.code-bucket
  s3_key        = aws_signer_signing_job.build_signing_job.signed_object[0]["s3"][0]["key"]
  function_name = var.lambda-name
  handler       = "lambda_function.lambda_handler"
  memory_size   = 128
  runtime       = "python3.8"
  role          = var.lambda-role
  timeout       = 45

  code_signing_config_arn = aws_lambda_code_signing_config.abc-signer-profile-config.arn

  depends_on = [data.archive_file.lambda_zip]
}

// Resource that zips up the Python file.
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda_function.py"
  output_path = "${path.module}/lambda.zip"
}

// Resource that uploads the zip file to S3.
resource "aws_s3_bucket_object" "zip-upload" {
  key                    = "unsigned/lambda.zip"
  bucket                 = var.code-bucket
  source                 = "${path.module}/lambda.zip"
  server_side_encryption = "AES256"

  depends_on = [data.archive_file.lambda_zip]
}
