#!/bin/sh

set -euo pipefail

echo "--- :terraform: Deploying.."

echo "Download files"
mkdir -p dist/
buildkite-agent artifact download dist/* dist/


echo "Terraform version1"
terraform version

terraform init


terraform apply -auto-approve