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

# not optional, defines source_opt_file
. "${BASH_SOURCE[0]%/*}/common_functions.shrc"

# optionals
source_opt_file "${BASH_SOURCE[0]%/*}/strict_bash.bashrc"
source_opt_file "${BASH_SOURCE[0]%/*}/history.bashrc"
source_opt_file "${BASH_SOURCE[0]%/*}/common_aliases.shrc"
source_opt_file "${BASH_SOURCE[0]%/*}/prog_settings.shrc"
source_opt_file "${BASH_SOURCE[0]%/*}/shell.local/temp.shrc"
source_opt_file "${BASH_SOURCE[0]%/*}/shell.local/temp.bashrc"
source_opt_file "${BASH_SOURCE[0]%/*}/theme.bashrc"
source_opt_file "/usr/share/doc/fzf/examples/key-bindings.bash"

sysname=$(uname -s)
if [ "${sysname:0:9}" == "CYGWIN_NT" ] || [ "${sysname:0:10}" == "MINGW32_NT" ] || [ "${sysname:0:10}" == "MINGW64_NT" ] || [ "${sysname:0:7}" == "MSYS_NT" ]; then :;
  source_opt_file "${BASH_SOURCE[0]%/*}/windows.shrc"
fi

# disable ctrl+s
stty -ixon

# update path
test "${PATH#*$HOME/bin:}" != "$PATH" || PATH="$HOME/bin:$PATH"
