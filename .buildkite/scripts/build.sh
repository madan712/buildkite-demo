#!/bin/bash

set -euo pipefail

echo "--- :building_construction: Builing.."

echo "Values inside script..."
#KK=$(buildkite-agent meta-data get "MYKEY")
#VV=$(buildkite-agent meta-data get "MYVALUE")
echo $MYKEY
echo $MYVALUE


echo "Installing"
yarn install

echo "Building..."
yarn build