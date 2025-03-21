#!/bin/bash

# Function to increment version numbers
increment_version() {
  local major=$1
  local minor=$2
  local patch=$3
  local type=$4

  if [[ "$type" == "major" ]]; then
    major=$((major + 1))
    minor=0
    patch=0
  elif [[ "$type" == "minor" ]]; then
    minor=$((minor + 1))
    patch=0
  else
    patch=$((patch + 1))
  fi

  echo "$major.$minor.$patch"
}

branchname=$(git rev-parse --abbrev-ref HEAD)
echo "Branch name: $branchname"

commithash=$(git rev-parse --short HEAD)
echo "Commit hash: $commithash"

buildtimestamp=$(date "+%Y-%b-%d-%H:%M:%S")
echo "Build timestamp: $buildtimestamp"

# Ensure we fetch all commits and tags, not just a shallow clone
fulltag=$(git describe --tag $(git rev-parse --verify refs/remotes/origin/main))

echo "Latest tag on origin/main: $fulltag"

versiontag=$(echo $fulltag | cut -d'-' -f1)
major=$(echo $versiontag | cut -d'.' -f1)
minor=$(echo $versiontag | cut -d'.' -f2)
patch=$(echo $versiontag | cut -d'.' -f3)
echo "Parsed version: $major.$minor.$patch"

if [[ "$branchname" == "main" && "$(git log -1 --pretty=%B)" =~ "major" ]]; then
  echo "Incrementing Major version"
  new_version=$(increment_version $major $minor $patch "major")
elif [[ "$branchname" == "main" && "$(git log -1 --pretty=%B)" =~ "minor" ]]; then
  echo "Incrementing Minor version"
  new_version=$(increment_version $major $minor $patch "minor")
else
  echo "Incrementing Patch version"
  new_version=$(increment_version $major $minor $patch "patch")
fi

echo "New version: $new_version"

buildversion="$new_version"
buildversionfilename=$(echo $buildversion | tr '.' '_')

echo "branchname=$branchname" >> $GITHUB_ENV
echo "commithash=$commithash" >> $GITHUB_ENV
echo "buildtimestamp=$buildtimestamp" >> $GITHUB_ENV
echo "buildversion=$buildversion" >> $GITHUB_ENV
echo "buildversionfilename=$buildversionfilename" >> $GITHUB_ENV
