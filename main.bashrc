#!/usr/bin/env bash

# main.bashrc: executed by bash for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# Make sure display get updated when terminal window get resized
shopt -q -s checkwinsize

# options for cd
[ "${BASH_VERSINFO[0]}" -ge 4 ] && shopt -s autocd  # change to named directory
shopt -s cdspell                                    # autocorrects cd misspellings


CURRENTDIR=$(dirname "${BASH_SOURCE[0]}")

# not optional, defines source_opt_file
. "$CURRENTDIR/common_functions.bashrc"

# optionals
source_opt_file "$CURRENTDIR/strict_bash.bashrc"
source_opt_file "$CURRENTDIR/xdg_paths.bashrc"
source_opt_file "$CURRENTDIR/history.bashrc"
source_opt_file "$CURRENTDIR/common_aliases.bashrc"
source_opt_file "$CURRENTDIR/temp.bashrc"

sysname=$(uname -s)
if [ "${sysname:0:9}" == "CYGWIN_NT" ]; then
  source_opt_file "$CURRENTDIR/windows.bashrc"
fi

