#!/usr/bin/env bash

# optionally sources one file (if exists)
source_opt_file() {
  if [ -f "$1" ]; then
    . "$1"
  fi
}

source_bashrc() {
  . "$HOME/.bashrc"
}

# defines an alias if it does not already exist
define_alias_ifndef() {
#! type $1 &>/dev/null && alias $1="$2"
# othervise (more verbose):
  if ! type $1 &> /dev/null; then
    alias $1="$2";
  fi
}

#like normal alias, but checks if the required program is avaiable
define_alias_opt() {
  if command -v "$1" > /dev/null 2>&1; then
    alias $2="$3";
  fi
}

# checks if dir exists and adds it to path
# FIXME: check if already in PATH
append_to_path(){
  if [ -d "$1" ]; then
    PATH=$PATH:"$1";
    return 0;
  fi
  return 1;
}

# repair permissions  of current directory (otherwise pass directory as parameter)
# intended for directories under the user home path
# FIXME: check if it works on windows
repair_dir_perm() {
  if [ -z "$1" ]; then
    DIRECTORY="."
  else
    DIRECTORY=$1
  fi
  find "$DIRECTORY" -type d -print0 | xargs -0 chmod 0775
  find "$DIRECTORY" -type f -print0 | xargs -0 chmod 0644
}

# sample: find_in_file "*.txt" hello
# globbing is your enemy here!
#FIXME: if directory matches pattern -> "error"
# try to apply: https://stackoverflow.com/questions/11456403/stop-shell-wildcard-character-expansion
find_in_file(){
  find . -name "$1" -exec grep --with-filename --color -n "$2" {} \;
}
#alias find_in_file='set -f;find_in_file;' # removes globbing completely, not just for this command!


