#########################################
# Code Signing Resources
#########################################
resource "aws_signer_signing_profile" "abc-signer-profile" {
  name_prefix = "abc_"
  platform_id = "AWSLambda-SHA384-ECDSA"
}
resource "aws_lambda_code_signing_config" "abc-signer-profile-config" {
  allowed_publishers {
    signing_profile_version_arns = [aws_signer_signing_profile.abc-signer-profile.version_arn]
  }
  policies {
    untrusted_artifact_on_deployment = "Enforce"
  }
}

resource "aws_signer_signing_job" "build_signing_job" {
  profile_name = aws_signer_signing_profile.abc-signer-profile.name

  source {
    s3 {
      bucket  = var.code-bucket
      key     = "unsigned/lambda.zip"
      version = "null"
    }
  }

  destination {
    s3 {
      bucket = var.code-bucket
      prefix = "signed/"
    }
  }

  ignore_signing_job_failure = false
  # For Option 1
  # depends_on                 = [aws_s3_bucket_object.zip-upload]

  # For Option 2
  depends_on = [null_resource.build_upload]
}