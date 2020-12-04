provider "aws" {
  region = var.region
  profile = "home"
  # assume_role {
  #   role_arn = var.role_arn
  # }
}