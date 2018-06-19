#!/usr/bin/env bash

# From:
# http://ajmccluskey.com/2015/01/executing-your-code-from-vim/
# https://github.com/ajmccluskey/misc-scripts

script="$1"; shift
last_mod=0

while true; do
    curr_mod=$(stat -f "%m" "$script")
    if ((curr_mod != last_mod)); then
        clear
        printf "\nOutput of %s:\n\n" "$script"
        "$script" "$@"
        script_ec=$?
        if (( $script_ec != 0 )); then
            printf "\nWARNING: %s exited with non-zero exit code %d" "$script" $script_ec >&2
        fi
        last_mod=$curr_mod
    fi

    sleep 1
done

exit 0
