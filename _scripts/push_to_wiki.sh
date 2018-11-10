#!/bin/bash

set +e

WIKI_DIR=`mktemp -d`

git clone https://github.com/${TRAVIS_REPO_SLUG}.wiki.git ${WIKI_DIR}

python3 _scripts/gen_wiki.py order.yaml ${WIKI_DIR}
cd ${WIKI_DIR}

git config credential.helper "store --file=.git/credentials"
echo "https://${GITHUB_TOKEN}:@github.com" > .git/credentials 2>/dev/null
git config --global user.email "bhuvan.venkatesh21@gmail.com"
git config --global user.name "Bhuvan Venkatesh"

git add -A
git commit -m "Updating wiki"
git push origin

cd ${TRAVIS_BUILD_DIR}