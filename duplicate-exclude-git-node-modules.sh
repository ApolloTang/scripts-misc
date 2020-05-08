#!/usr/bin/env bash

# This script clone a folder to specified destination,
# it exclude node_modules/ and .git/

echo $1
if [ -z "$1" ]
  then
    echo "[!] please specify source folder"
    exit 1
fi

sourcefolder="$1/"  # <--- sourcefolder must end with '/'
destinationName="$1--duplicate"
echo '### Duplicate folder and its contents, excluding .git/ and node_modules/: '
echo " Folder to duplicate: $sourcefolder"
echo " Destination        : $destinationName"



rsync -havp $sourcefolder $destinationName --exclude node_modules --exclude .git
# The excluded folder  is relative to the sourcefolder
# if souce is a folder it must end with slas
