#!/usr/bin/env bash

# ls
define_alias_ifndef 'll' 'ls -lh'
define_alias_ifndef 'la' 'ls -a'
define_alias_ifndef 'l' 'ls'

# wget
alias wget='wget -c'

# grep
#export GREP_OPTIONS='--color=auto' # deprecated --> alternatives without using alias???
alias grep='grep --color=auto'

# gp
define_alias_opt 'gp' 'gp' 'gp -q'

######################################
# new_alias                          #
# creates new alias & writes to file #
#  $1 = alias new                    #
#  $2 = alias definition             #
######################################
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

  echo "alias $NAME='$DEFINTION'" >> ~/.new_aliases
  . ~/.new_aliases
}

# include aliases added with new-alias
if [ -f "$HOME/.new_aliases" ]; then
    . "$HOME/.new_aliases"
fi
