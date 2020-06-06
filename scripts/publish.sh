#!/usr/bin/env bash
echo 'Publish Release of Tile'

npm i

git add .

release-it --ci --no-npm --no-git.push --no-git.requireCleanWorkingDir --verbose -VV

VERSION=$(eval git describe --tags --abbrev=0)

# Setup Offering Registration Command with current version included
cat scripts/offering.sh | sed "s/VERSION=/VERSION=${VERSION}/g" > ./offering.sh
cp scripts/offering.json .
chmod +x offering.sh
git add .

git commit -m "Latest Iteration Zero Terraform stages"
git push --follow-tags -v

echo 'Release complete .......'
