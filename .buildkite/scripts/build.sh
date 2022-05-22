#!/usr/bin/env bash

set -euo pipefail

echo "--- :building_construction: Builing.."

echo "Installing"
yarn install

echo "Building.."
yarn build