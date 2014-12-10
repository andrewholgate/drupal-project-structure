#!/bin/bash
#
# Backup files directory.
#
PATH_CURRENT=`pwd`
PATH_PROJECT=`readlink current`
COMMIT=$(git --git-dir $PATH_PROJECT/../.git rev-parse --short HEAD)
NAME=$(date +%Y%m%d_%k%M%S)_commit_$COMMIT.files.tar.gz

echo "Backing up files."
#cd $PATH_PROJECT

tar --exclude='*.css' --exclude='*.css.gz' --exclude='*.js' --exclude='*.js.gz' -zcvf files/$NAME current/sites/default/files/
echo
echo "Files archive available at: files/$NAME"

if [ "$1" == "--link" ]
then
  cd  $PATH_PROJECT
  ln -s ../../../files/$NAME
  echo "Files downloadable via: /$NAME"
  echo "Files removable via: rm $PATH_PROJECT/$NAME"
fi

