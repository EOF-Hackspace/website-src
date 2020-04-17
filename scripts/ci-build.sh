#!/bin/bash

# skip if build is triggered by pull request
if [[ $TRAVIS_PULL_REQUEST == "true" ]]; then
  echo "this is PR, exiting."
  exit 0
fi

# enable error reporting to the console
set -e

TARGET_REPO="website-src"
TARGET_BRANCH="gh-pages"
USE_PROD_CONFIG="false"
DISABLE_ROBOTS="true"

if [[ $TRAVIS_BRANCH == "production" ]]; then
  IS_PROD_BUILD="true"
fi

if [[ $IS_PROD_BUILD == "true" ]]; then
  echo "Using Production Build settings."
  TARGET_REPO="website-production"
  TARGET_BRANCH="master"
  DISABLE_ROBOTS="false"
  USE_PROD_CONFIG="true"
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
  echo "Using Production config file."
  cp -f ./_config.production.yml ./_config.yml
fi

# build with Jekyll into "_site"
gem install bundler -v 1.17.2 # hack to deal with https://bundler.io/blog/2019/01/04/an-update-on-the-bundler-2-release.html
bundle exec jekyll build
#bundle exec htmlproofer ./_site

# Overwrite robots.txt if needed
if [[ $DISABLE_ROBOTS == "true" ]]; then
  echo "Using disabled robots.txt."
  cp -f ./robots.disabled.txt ./_site/robots.txt
fi

# Bring in correct CNAME file for Github Pages hosting
rm -f ./_site/CNAME*
if [[ $IS_PROD_BUILD == "true" ]]; then
  echo "Using Production CNAME."
  echo "eof.org.uk" > ./_site/CNAME
else
  echo "Using Testing CNAME."
  echo "testing.eof.org.uk" > ./_site/CNAME
fi

# push
cd _site
rm README.md
git config user.email "MetaFight@users.noreply.github.com"
git config user.name "MetaFight"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin ${TARGET_BRANCH}
