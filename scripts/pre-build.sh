#!/bin/bash
set -euxo pipefail

cd ./src

if [[ $GITHUB_REF_NAME == "production" ]]; then
  echo "Using Production config file."
  cp -f ./_config.production.yml ./_config.yml
fi