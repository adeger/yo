#! /bin/bash

# assume regions defined in aws_region variable
aws s3 mb s3://yo-files
aws s3 cp vpc-privatepublic.yaml s3://yo-files
aws cloudformation create-stack --stack-name ebs-stage-stack --template-url https://s3-us-west-2.amazonaws.com/yo-files/vpc-privatepublic.yaml
