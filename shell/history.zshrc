#!/usr/bin/env zsh

###################
# Eternal history #
###################

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

HISTFILE="$XDG_CACHE_HOME/zhistfile"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
