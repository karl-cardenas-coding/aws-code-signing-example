# output "signed-object" {
#   value = aws_signer_signing_job.build_signing_job.signed_object
# }

output "signeList" {
  value = local.signedSourceList
}