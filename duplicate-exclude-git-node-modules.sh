#!/usr/bin/env bash

#
# This script take a folder path:
#
#   /path/to/folder
#
# and make a duplication of its content to a destination folder path:
#
#   /path/to/folder--duplicate
#
# The duplicated content excluded top level node_modules and .git
#
# Note that the trailing slash of the source folder should be specified.
#
#    wrong:   /path/to/folder/
#    correct: /path/to/folder
#

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
# if souce is a folder it must end with slash

