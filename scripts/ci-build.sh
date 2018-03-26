#!/bin/bash

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

TARGET_REPO="website-src"
TARGET_BRANCH="gh-pages"
USE_PROD_CONFIG="false"

mv ./CNAME.testing ./_site/CNAME

if [ $IS_PROD_BUILD == "true" ]; then
  TARGET_REPO="website-deployed"
  TARGET_BRANCH="master"
  # temporarily disabled until PROD domain is sorted out.
  #USE_PROD_CONFIG="true"

  mv ./CNAME.production ./_site/CNAME
fi

# clone target repo to "_site"
git clone https://${GH_TOKEN}@github.com/EOF-Hackspace/${TARGET_REPO}.git --branch ${TARGET_BRANCH} _site

if [ $USE_PROD_CONFIG == "true" ]; then
  mv -f ./_config.production.yml ./_config.yml
fi

# build with Jekyll into "_site"
bundle exec jekyll build
#bundle exec htmlproofer ./_site

if [ $DISABLE_ROBOTS == "true" ]; then
  mv -f ./robots.disabled.txt ./_site/robot.txt
fi

# push
cd _site
git config user.email "MetaFight@users.noreply.github.com"
git config user.name "MetaFight"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin ${TARGET_BRANCH}