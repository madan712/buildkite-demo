#!/bin/sh

set -euo pipefail

echo "--- :terraform: Deploying.."

echo "Download files"
mkdir -p dist/
buildkite-agent artifact download dist/* dist/

echo "Values inside script..."
echo $MYKEY


pwd
ls -ltr

echo "Files..."
cd dist
pwd
ls -ltr

cd ..
pwd

export AWS_ACCESS_KEY_ID="$MYKEY"
export AWS_SECRET_ACCESS_KEY="$MYVALUE"

echo "Terraform version.."
terraform version

terraform init

terraform apply -auto-approve