#!/usr/bin/env bash

# This script clone a folder to specified destination,
# it exclude node_modules/ and .git/

echo $1 $2
if [ -z "$1" ]
  then
    echo "[!] please specify source folder"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "[!] please specify destination folder"
    exit 1
fi

echo '### Clone folder and its contents, excluding .git/ and node_modules/: '
echo " source:      $1"
echo " destination: $2"

if [ -d "$2" ]; then
  echo "[!] Destination folder already exist"
  exit 1
fi

if [ ! -d "$1" ]; then
  echo "[!] Source folder does not exist"
  exit 1
fi


rsync -havp $1 $2 --exclude node_modules --exclude .git
# The excluded folder  is relative to the sourcefolder
# if souce is a folder it must end with slash: 'sourceFolder/'
