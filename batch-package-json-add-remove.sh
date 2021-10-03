#!/bin/bash

dir=$(pwd)
config=$dir\/script-config.sh

## Place the following in script-config.sh
## ---------------------------------------
## packageName='xxx'
## packageVersion='0.1.1'
##
## dependency_type='prod'
## # dependency_type='dev'
##
## # export action='add'
## action='remove'
## ---------------------------------------

if [[ ! -f $config ]] ; then
  echo "File $config not present, aborting."
  echo '
  Place the following in script-config.sh
  ---------------------------------------
  packageName='xxx'
  packageVersion='0.1.1'

  dependency_type='prod'
  # dependency_type='dev'

  # export action='add'
  action='remove'
  ---------------------------------------
  '
  exit
fi

chmod 744 "$config"
source $config

echo '   packageName ' $packageName
echo 'packageVersion ' $packageVersion
echo 'dependency_type' $dependency_type
echo '        action ' $action
echo '--------- configration read'

##--------------------------------------------------------
##
## This script uses: gsed and jq
##
KEY_DEV_DEP='devDependencies'
KEY_PRD_DEP='dependencies'

if [[ "$dependency_type" == 'prod' ]]; then
  echo ">>> update key: devDependencies"
  dep_type="$KEY_PRD_DEP"
fi

if [[ "$dependency_type" == 'dev' ]]; then
 echo ">>> update key: dependencies"
 dep_type="$KEY_DEV_DEP"
fi

JQ_FILTER_ADD=".$dep_type += {\"$packageName\": \"$packageVersion\"}"
JQ_FILTER_REMOVE="with_entries(select(.key==\"$dep_type\").value |= del(.$packageName))"

if [[ "$action" == 'add' ]]; then
 filter="$JQ_FILTER_ADD"
 echo ">>> adding package:: $packageName@$packageVersion"
fi

if [[ "$action" == 'remove' ]]; then
 filter="$JQ_FILTER_REMOVE"
 echo ">>> remove package: $packageName"
fi

for fn in ./utils/**/package.json; do
  fn_backup=$(echo $fn | gsed -E 's/(.*)\.json/\1-backup.json/')

  echo 'backup >>>' $fn $fn_backup
  cp $fn $fn_backup

  echo 'jq filter >>>' $filter
  jq "$filter" $fn_backup > $fn
done


