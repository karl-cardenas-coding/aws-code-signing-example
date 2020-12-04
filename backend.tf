terraform {
  backend "s3" {
    bucket = "terraform-statefiles-karl-cardenas-coding"
    key    = "aws-code-signing-example/state.tfstate"
    region = "us-east-1"
    # role_arn = "arn:aws:iam::140040602879:role/automation-role"
    encrypt        = true
  }
}