#!/bin/bash
#
# Open new iTerm window from the command line
#
# Usage:
#     iterm                   Opens the current directory in a new iTerm window
#     iterm [PATH]            Open PATH in a new iTerm window
#     iterm [CMD]             Open a new iTerm window and execute CMD
#     iterm [PATH] [CMD] ...  You can prob'ly guess
#
# Example:
#     iterm ~/Code/HelloWorld ./setup.sh
#
# References:
#     iTerm AppleScript Examples:
#     https://gitlab.com/gnachman/iterm2/wikis/Applescript
#
# Credit:
#     Inspired by tab.bash by @bobthecow
#     link: https://gist.github.com/bobthecow/757788
#
# Found at:
# https://stackoverflow.com/questions/56862644/open-iterm2-from-bash-script-run-commands
#




# OSX only
[ `uname -s` != "Darwin" ] && return

echo 'launch iterm at path: ' $@

function iterm () {
    local cmd=""
    local wd="$PWD"
    local args="$@"

    if [ -d "$1" ]; then
        wd="$1"
        args="${@:2}"
    fi

    if [ -n "$args" ]; then
        # echo $args
        cmd="; $args"
    fi

    osascript &>/dev/null <<EOF
        tell application "iTerm"
            activate
            set term to (make new terminal)
            tell term
                launch session "Default Session"
                tell the last session
                    delay 1
                    write text "cd $wd$cmd"
                end
            end
        end tell
EOF
}
iterm $@
