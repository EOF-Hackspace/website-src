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

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/EOF-Hackspace/website-deployed.git --branch master _site

# build with Jekyll into "_site"
bundle exec jekyll build
#bundle exec htmlproofer ./_site

mv -f ./robot.txt.production ./_site/robot.txt

# push
cd _site
git config user.email "MetaFight@users.noreply.github.com"
git config user.name "MetaFight"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin master