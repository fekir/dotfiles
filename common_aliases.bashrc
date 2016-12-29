#!/usr/bin/env bash

# ls
eval "$(dircolors)"
# colors for source files
src_file_color="01;33"
LS_COLORS="$LS_COLORS*.cpp=$src_file_color:*.hpp=$src_file_color:*.cxx=$src_file_color:*.hxx=$src_file_color:*.c=$src_file_color:*.h=$src_file_color:*.cmake=$src_file_color:" # c, c++
LS_COLORS="$LS_COLORS*.java=$src_file_color" # java
alias ls='ls --color=auto'
define_alias_ifndef 'll' 'ls -lh --color=auto'
define_alias_ifndef 'la' 'ls -A --color=auto'
define_alias_ifndef 'l.' 'ls -Ad .* --color=auto'
define_alias_ifndef 'll.' 'ls -lhAd .* --color=auto'
define_alias_ifndef 'l' 'ls --color=auto'
define_alias_ifndef 'lsd' 'ls --group-directories-first --color=auto'

# wget
alias wget='wget -c'

# grep
#export GREP_OPTIONS='--color=auto' # deprecated --> alternatives without using alias???
alias grep='grep --color=auto'

# gp
define_alias_opt 'gp' 'gp' 'gp -q'

define_alias_opt 'xlsclients' 'show_daemons' 'ps -C "$(xlsclients | cut -d\  -f3 | paste - -s -d \",\")" --ppid 2 --pid 2 --deselect -o tty,uid,pid,ppid,args'

# make
# invoke make with -j"numberofoprocs", you can override it by using -j
export MAKEFLAGS="-j$(($(grep -c processor /proc/cpuinfo)+1))"

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

############################################
# new_alias                                #
# creates new alias & writes to file       #
#  $1 = alias new                          #
#  $2 = alias definition                   #
# Problems if alias contains single quotes #
############################################
new_alias () {
  if [ -z "$1" ]; then
    echo 'alias name:'
    read -r NAME
  else
    NAME=$1
  fi

  if [ -z "$2" ]; then
    echo 'alias definition:'
    read -r DEFINTION
  else
    if [ "$2" = "-cd" ]; then
      DEFINTION='cd '
    else
      DEFINTION=$2
    fi
  fi

  echo "alias $NAME='$DEFINTION'" >> "$HOME/.new_aliases"
  . "$HOME/.new_aliases"
}

# include aliases added with new-alias
if [ -f "$HOME/.new_aliases" ]; then
    . "$HOME/.new_aliases"
fi
