#!/bin/bash
#
# Backup current database.
#
PATH_CURRENT=`pwd`
PATH_PROJECT=`readlink current`
COMMIT=$(git --git-dir $PATH_PROJECT/../.git rev-parse --short HEAD)
NAME=$(date +%Y%m%d_%H%M%S)_commit_$COMMIT.sql

echo Backing up database.
cd $PATH_PROJECT

drush sql-dump --skip-tables-key=common --gzip --result-file=$PATH_CURRENT/databases/$NAME
echo

if [ "$1" == "--link" ]
then
  ln -s ../../../databases/$NAME.gz
  echo "Database downloadable via: /$NAME.gz"
  echo "Database removable via: rm $PATH_PROJECT/$NAME.gz"
fi

