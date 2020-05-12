#!/usr/bin/env bash
echo 'Publish Release of Tile'

npm i
git add .
git commit -m "Latest Iteration Zero Terraform stages"

release-it patch ${PRE_RELEASE} --ci --no-npm --no-git.push --no-git.requireCleanWorkingDir                       --verbose                       -VV

git push --follow-tags -v

echo 'Release complete .......'
