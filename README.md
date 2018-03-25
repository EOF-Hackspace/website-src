# EOF Hackspace Website Repository

## Read Me

This is the repository containing the EOF website source.

## Branches

* `master` - This contains the code deployed to the live site.
* `gh-pages` - This contains the code deployed to the **staging** site.  This is not the actual website, but it is still viewable by the public if they know the URL. 

## Developmment

Development will typically happen in the `gh-pages` branch.  Changes to this branch are automatically deployed to https://eof-hackspace.github.io/website-src/ allowing the developer to preview their changes before pushing to the live site.  (It may take up to a minute for the preview to update)

When the changes in `gh-pages` are ready to go live, the developer should create a **Pull Request** to `master`.  At this point the Pull Request will be reviewed.

If approved, the changes will be merged to `master` and the Continous Integration setup (Travis CI) will build the site and deploy it the the `EOF-Hackspace/website-deployed` repository.  The changes will then become visible at https://www.eof.org.uk .
