#!/usr/bin/env bash

###################
# Eternal history #
###################

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# size and length
HISTSIZE=1000
HISTFILESIZE=2000


# Taken from https://debian-administration.org/article/543/Bash_eternal_history
export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'

