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
. "$CURRENTDIR/common_functions.shrc"

detect_term

# optionals
source_opt_file "$CURRENTDIR/strict_bash.bashrc"
source_opt_file "$CURRENTDIR/history.bashrc"
source_opt_file "$CURRENTDIR/common_aliases.shrc"
source_opt_file "$CURRENTDIR/prog_settings.shrc"
source_opt_file "$CURRENTDIR/shell.local/temp.shrc"
source_opt_file "$CURRENTDIR/shell.local/temp.bashrc"
source_opt_file "$CURRENTDIR/theme.bashrc"

sysname=$(uname -s)
if [ "${sysname:0:9}" == "CYGWIN_NT" ]; then
  source_opt_file "$CURRENTDIR/windows.shrc"
fi

# disable ctrl+s
stty -ixon

# update path
test "${PATH#*$HOME/bin:}" != "$PATH" || PATH="$HOME/bin:$PATH"
