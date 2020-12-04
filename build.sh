#!/bin/bash
set -e

zip lambda.zip ./lambda_function.py 
aws s3 cp --profile="demo" lambda.zip s3://code-signing-demo/unsigned
aws signer start-signing-job --profile="demo" --profile-name="abc_20201129171057064200000001"  --source "s3={bucketName='code-signing-demo',key='unsigned/lambda.zip',version="null"}" --destination "s3={bucketName='code-signing-demo',prefix=signed/lambda-}"