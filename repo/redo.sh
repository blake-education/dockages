#!/bin/bash

set -e

# I have this file from s3cmd (I think)
# Paper over the differences:
if [[ -f "$EC2_CREDENTIALS_FILE" ]]; then
  source $EC2_CREDENTIALS_FILE
  AWS_ACCESS_KEY_ID="$AWSAccessKeyId"
  AWS_SECRET_ACCESS_KEY="$AWSSecretKey"
fi


docker build --rm -t dockages/ruby-repo .
docker run -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY dockages/ruby-repo
