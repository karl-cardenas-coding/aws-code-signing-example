#!/bin/bash
set -e

zip lambda.zip ./lambda_function.py 
aws s3 cp lambda.zip s3://${var.code-bucket}/unsigned
aws signer start-signing-job --profile-name="demo"  --source "s3={bucketName='code-signing-demo',key='unsigned/lambda.zip',version="null"}" --destination "s3={bucketName='code-signing-demo',prefix=signed/lambda-}"