#!/usr/bin/env sh
echo 'Publish Release of Tile'

set -e

npm i -g release-it

# Release the Version
release-it --ci --no-npm minor --verbose -VV -c .release-it.yaml

echo 'Release complete .......'
