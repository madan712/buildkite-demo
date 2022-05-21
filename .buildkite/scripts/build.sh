#!/usr/bin/env bash

set -euo pipefail

echo "--- :building_construction: Builing.."

whoami

sudo su buildkite-agent

whoami

echo "Installing"
yarn install

echo "Building"
yarn build