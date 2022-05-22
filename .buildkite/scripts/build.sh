#!/bin/bash

set -euo pipefail

echo "--- :building_construction: Builing.."

echo "Values inside script..."
KK=$(buildkite-aget meta-data get "MYKEY")
VV=$(buildkite-aget meta-data get "MYVALUE")
echo $KK
echo $VV


echo "Installing"
yarn install

echo "Building..."
yarn build