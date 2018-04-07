#!/bin/bash

bundle install --local
exec jekyll serve -H 0.0.0.0 --livereload --livereload-port 35729