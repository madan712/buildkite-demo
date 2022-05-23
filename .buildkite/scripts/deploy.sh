#!/bin/sh

set -euo pipefail

echo "--- :terraform: Deploying.."

echo "Download files"
mkdir -p dist/
buildkite-agent artifact download dist/* dist/

echo "Values inside script..."
echo $MYKEY


pwd


echo "Terraform version.."
terraform version

terraform init

terraform apply -auto-approve