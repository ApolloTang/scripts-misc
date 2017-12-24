#!/bin/sh

# This is actually homebrew version of /usr/local/bin/mvim
# It is modified so that it can be executed outside /usr/local/bin; it
# is then wrapped inside mvim.app so it can be called as an OSX application
#
# This is necessay because MacVim.app does not open a window
# with Mvim.app, when it is called a new window will spawn
#
# Also, MacVim.app will launch with $HOME/Desktop ad the current working directory


# set Vim executable
source $HOME/.bashrc   # need to source rc file in case $VIM_IN_MACVIM not yet defined
binary=$VIM_IN_MACVIM  # This is the trick,
                       # location of vim binary for MacVim.app is specify in
                       # ~/1/1-sy/configurations/bash/<deviceName>/git-sub-local/local-only.sh

if ! [ -x "$binary" ]; then
  echo "Sorry, cannot find Vim executable."
  exit 1
fi

# Next, peek at the name used to invoke this script, and set options
# accordingly.

name="`basename "$0"`"
gui=
opts=

# GUI mode, implies forking
case "$name" in m*|g*|rm*|rg*) gui=true ;; esac

# Logged in over SSH? No gui.
if [ -n "${SSH_CONNECTION}" ]; then
  gui=
fi

# Restricted mode
case "$name" in r*) opts="$opts -Z";; esac

# vimdiff, view, and ex mode
case "$name" in
  *vimdiff)
    opts="$opts -dO"
    ;;
  *view)
    opts="$opts -R"
    ;;
  *ex)
    opts="$opts -e"
    ;;
esac

# Last step:  fire up vim.
# The program should fork by default when started in GUI mode, but it does
# not; we work around this when this script is invoked as "gvim" or "rgview"
# etc., but not when it is invoked as "vim -g".
if [ "$gui" ]; then
  # Note: this isn't perfect, because any error output goes to the
  # terminal instead of the console log.
  # But if you use open instead, you will need to fully qualify the
  # path names for any filenames you specify, which is hard.

  cd $HOME/Desktop
  exec "$binary" -g $HOME/Desktop   #/ if gui dont edit any file just set working dir
  # exec "$binary" -g $opts ${1:+"$@"}
else
  exec "$binary" $opts ${1:+"$@"}
fi

#/ for meaning of ${1:+"$@"} see:
#/ https://unix.stackexchange.com/questions/68484/what-does-1-mean-in-a-shell-script-and-how-does-it-differ-from

