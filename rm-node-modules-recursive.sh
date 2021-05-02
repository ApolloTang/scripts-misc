#!/usr/bin/env bash

# -----------------------------------------------------------------
#
# This script remove all node_modules/ folder recusively in the pwd
#
# Todo:
#   add a -n flag for dry run
#   print out removing path
#
# -----------------------------------------------------------------

find . -type d -name node_modules -prune -exec rm -rf {} \;

# ---eof---
