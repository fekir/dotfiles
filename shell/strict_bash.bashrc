#!/usr/bin/env bash

# causes a pipeline to produce a failure return code if any command fails.
set -o pipefail

# Get immediate notification of background job termination
set -o notify

# check if running interactively
case $- in
    *i*) # interactive
         ;;
      *) # not interactive
         # makes the whole script exit on error, instead of just resuming on the next line (unsuitable for shell (it gets closed))
         set -o errexit
         # treat unset variables as an error (unsuitable for shell (autocompletion))
         set -o nounset
         ;;
esac


