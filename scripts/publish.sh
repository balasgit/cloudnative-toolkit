#!/usr/bin/env bash
echo 'Publish Release of Tile'

npm i

git add .

# Release the Version
release-it --ci --no-npm --no-git.push --no-git.requireCleanWorkingDir --verbose -VV

# Setup Offering Registration Command with current version included
VERSION=$(eval git describe --tags --abbrev=0)
cat scripts/master.sh | sed "s/VERSION=/VERSION=${VERSION}/g" > ./offering.sh
cp scripts/master.json ./offering.json
chmod +x offering.sh
git add .

git commit -m "Latest Iteration Zero Terraform stages"
git push --follow-tags -v

echo 'Release complete .......'
