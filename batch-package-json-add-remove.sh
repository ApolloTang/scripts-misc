#!/bin/bash

dir=$(pwd)
config=$dir\/script-config.sh

## Place the following in script-config.sh
## ---------------------------------------
## key='xxx'
## value='0.1.1'
##
## dependency_type='prod'
## # dependency_type='dev'
##
## # export action='add'
## action='remove'
## ---------------------------------------

if [[ ! -f $config ]] ; then
printf "\nFile $config not present, aborting."
echo '
Paste the following in terminal:
---------------------------------------
cat <<- EOF > script-config.sh
key='xxx'
value='0.1.1'

field='prod'
# field='dev'
# field='scripts'

# action='update'
action='remove'

paths=(
  ./utils/common-*/package.json \  # you can use globe
  ./path/to/my/package.json     \  # specified the path to file
)

EOF
--------------------------------------
'
  exit
fi

chmod 744 "$config"
source $config

echo '--- Configuration ---'
echo '    action: ' $action
echo '       key: ' $key
echo '     value: ' $value
echo '     field: ' $field

##--------------------------------------------------------
##
## This script uses: gsed and jq
##
FIELD_DEV_DEP='devDependencies'
FIELD_PROD_DEP='dependencies'
FIELD_SCRIPTS='scripts'

echo '--- Operation ---'
if [[ "$field" == 'prod' ]]; then
  echo "  update field: devDependencies"
  field_type="$FIELD_DEV_DEP"
fi

if [[ "$field" == 'dev' ]]; then
 echo "  update field: dependencies"
 field_type="$FIELD_PROD_DEP"
fi

if [[ "$field" == 'scripts' ]]; then
 echo "update field: scripts"
 field_type="$FIELD_SCRIPTS"
fi

JQ_FILTER_ADD=".$field_type += {\"$key\": \"$value\"}"
JQ_FILTER_REMOVE="with_entries(select(.key==\"$field_type\").value |= del(.$key))"

if [[ "$action" == 'update' ]]; then
 filter="$JQ_FILTER_ADD"
 echo "  update key: $key@$value"
fi

if [[ "$action" == 'remove' ]]; then
 filter="$JQ_FILTER_REMOVE"
 echo "  remove key: $key"
fi


echo '--- Start ---'
for fn in "${paths[@]}"; do
  if [[ -f $fn ]] ; then
    fn_backup=$(echo $fn | gsed -E 's/(.*)\.json/\1-backup.json/')

    echo '   backup: ' $fn_backup
    cp $fn $fn_backup

    echo 'jq filter: ' $filter
    jq "$filter" $fn_backup > $fn
  else
    echo file: '"'$fn'"' does not exist
  fi
done


