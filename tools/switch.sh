#!/bin/bash
#
# Initial project setup
#

if [ -n "$1" ]; then
  rm current
  ln -s release/$1/build current
fi

