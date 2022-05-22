#!/bin/bash

set -euo pipefail

echo "--- :building_construction: Builing.."

echo "Values..."
#echo "KEY=${MYKEY}"
#echo "VALUE=${MYVALUE}"


echo "Installing"
yarn install

echo "Building..."
yarn build