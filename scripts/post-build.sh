#!/bin/bash

cd ./src

if [[ $GITHUB_REF_NAME != "production" ]]; then
  echo "Using disabled robots.txt."
  cp -f ./robots.disabled.txt ./_site/robots.txt
fi

if [[ $GITHUB_REF_NAME != "production" ]]; then
  rm -f ./_site/CNAME*
  echo "Using Production CNAME."
  echo "eof.org.uk" > ./_site/CNAME
fi