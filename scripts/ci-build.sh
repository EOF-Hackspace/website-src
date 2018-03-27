#!/bin/bash

# skip if build is triggered by pull request
if [[ $TRAVIS_PULL_REQUEST == "true" ]]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

TARGET_REPO="website-src"
TARGET_BRANCH="gh-pages"
USE_PROD_CONFIG="false"
DISABLE_ROBOTS="true"

if [[ $IS_PROD_BUILD == "true" ]]; then
  TARGET_REPO="website-deployed"
  TARGET_BRANCH="master"
  # temporarily disabled until PROD domain is sorted out.
  #DISABLE_ROBOTS="false"
  #USE_PROD_CONFIG="true"
fi

# clone target repo to "_site"
rm -rf _site
mkdir _site
git clone https://${GH_TOKEN}@github.com/EOF-Hackspace/${TARGET_REPO}.git --branch ${TARGET_BRANCH} _site
cd _site
git rm -r * -f -q
cd ..

# Use appropriate config file
if [[ $USE_PROD_CONFIG == "true" ]]; then
  echo "Using Production config file"
  mv -f ./_config.production.yml ./_config.yml
fi

mv ./_pages/* ./

# build with Jekyll into "_site"
bundle exec jekyll build
#bundle exec htmlproofer ./_site

# Overwrite robots.txt if needed
if [[ $DISABLE_ROBOTS == "true" ]]; then
  echo "Using disabled robots.txt"
  mv -f ./_site/robots.disabled.txt ./_site/robots.txt
else
  echo "Using generated robots.txt"
  rm ./_site/robots.disabled.txt
fi

# Bring in correct CNAME file for Github Pages hosting
rm -f ./_site/CNAME*
if [[ $IS_PROD_BUILD == "true" ]]; then
  echo "Using Production CNAME"
  cp ./CNAME.production ./_site/CNAME
else
  echo "Using Testing CNAME"
  cp ./CNAME.testing ./_site/CNAME
fi

# push
cd _site
rm README.md
git config user.email "MetaFight@users.noreply.github.com"
git config user.name "MetaFight"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin ${TARGET_BRANCH}