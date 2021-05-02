#!/usr/bin/env bash

# -----------------------------------------------------------------
#
# This script remove all node_modules/ folder recusively in the pwd
#
# -----------------------------------------------------------------

find . -type d -name node_modules -prune -exec rm -rf {} \;

# ---eof---
