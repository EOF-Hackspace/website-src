![Build Status](https://api.travis-ci.org/EOF-Hackspace/website-src.svg?branch=master)

# EOF Hackspace Website Repository

This is the repository containing the EOF website source.

## Branches

* `master` - This is where the raw site code lives.
* `gh-pages` - This is where the *compiled* site code lives.  This branch is updated automatically so you don't need to touch it.

## Development

Development happens in the `master` branch.  Changes to this branch are automatically built using Travis CI and then pushed to the `gh-pages` branch.  Once there, the changes can be viewed at https://eof-hackspace.github.io/website-src/ .  This should allow the developer to preview their changes (relatively) quickly.

When the changes in `gh-pages` are ready to go live, the developer should notify me, Yves Conan.  I'll trigger a Production build.

The Production build is very similar.  It takes the contents of `master`, build them, and deploys them to the `master` branch of the `EOF-Hackspace/website-deployed` repository.  The changes will then become visible at https://www.eof.org.uk .

I'm hoping to simplify the build/deployment to Production in the future.
