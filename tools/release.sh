#!/bin/bash
#
# Project release creation.
#

RELEASE="$1"
BRANCH="$2"
RELEASE_DIR=releases/$RELEASE

if [[ $RELEASE != v* ]] || [[ -z $BRANCH ]]; then
  echo "Usage: $0 [release version] [git branch]"
  echo "Example: $0 v1.0.0 master "
  exit 1;
fi

if [ -d "$RELEASE_DIR" ]; then
  echo "The release $RELEASE already exists at: $RELEASE_DIR"
  echo "You must specify a different release name from an existing release."
  exit 1;
fi

# TODO Backup database

# Retreive current git remote
cd current
REMOTE=$(git config --get remote.origin.url)
cd ..
echo
echo "Using remote git: $REMOTE"

# Clone current git repo, using the specified branch.
git clone -b $BRANCH $REMOTE $RELEASE_DIR

# Install and update using Composer
composer --working-dir=$RELEASE_DIR install
composer --working-dir=$RELEASE_DIR update

# Copy files directory from current release.
echo
echo "Copying files directory.."
rsync -a --stats current/sites/default/files $RELEASE_DIR/build/sites/default/files --exclude css --exclude js --exclude advagg_js --exclude advagg_css
echo

while true; do
    read -p "Do you wish to make the new $RELEASE release the 'current' release? " yn
    case $yn in
        [Yy]* ) rm current &&ln -s $RELEASE_DIR/build current && echo "The current release is now $RELEASE"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer y or n";;
    esac
done

echo
echo "Release completed."

