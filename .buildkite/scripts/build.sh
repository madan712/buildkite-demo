#!/bin/bash

set -euo pipefail

echo "--- :building_construction: Builing.."

echo "Values inside script..."
echo $MYKEY
echo $MYVALUE


echo "Installing"
yarn install

echo "Building..."
yarn build