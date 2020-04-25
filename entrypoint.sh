#!/bin/sh

export WORKSPACE_REPOSITORY="$INPUT_REPOSITORY"
export CRAWLER_REPOSITORY="$INPUT_CRAWLER"
export OUTPUT_REPOSITORY="$INPUT_OUTPUT"

# Clone crawler
mkdir /crawler

export GITHUB_WORKSPACE="/crawler"
export GITHUB_REPOSITORY="$CRAWLER_REPOSITORY"

node /checkout.js

# Clone workspace
mkdir /workspace

export GITHUB_WORKSPACE="/workspace"
export GITHUB_REPOSITORY="$WORKSPACE_REPOSITORY"

node /checkout.js

# Inject .env from workspace
touch /workspace/.env
cp /workspace/.env /crawler/.env

# Install crawler dependencies
cd /crawler
npm install

# Clone output
mkdir /output

export GITHUB_WORKSPACE="/output"
export GITHUB_REPOSITORY="$OUTPUT_REPOSITORY"

node /checkout.js

# Run crawler

export OUTPUT="/output"
export EMAIL="$INPUT_EMAIL"
export PASSWORD="$INPUT_PASSWORD"

node /crawler/index.js

# Commit the changes
cd /output

git add .
git commit -m "$INPUT_COMMITMESSAGE"

# Push changes
force_option=""

if $INPUT_FORCE; then
  force_option="--force"
fi

remote="https://$INPUT_ACTOR:$INPUT_TOKEN@github.com/$OUTPUT_REPOSITORY.git"

git push $remote "HEAD:$INPUT_BRANCH" $force_option