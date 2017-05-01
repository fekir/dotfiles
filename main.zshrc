#!/usr/bin/env zsh

# main.zshrc: executed by zsh for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Fortune message
if cowsay "test" > /dev/null 2>&1 ; then
  message="Welcome"
  if fortune > /dev/null 2>&1 ; then
    message=$(fortune -s)
  fi
  cowsay -f duck -- "$message"
elif figlet "test" > /dev/null 2>&1 ; then
  figlet "Welcome!"
fi

# separator for forward/backward-word
export WORDCHARS='[]=/(){}'

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kich1]}" overwrite-mode

bindkey "${terminfo[home]}"  beginning-of-line
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "^[[F" end-of-line

CURRENTDIR=${0:h}

# not optional, defines source_opt_file
. "$CURRENTDIR/common_functions.shrc"

# optionals
source_opt_file "$CURRENTDIR/xdg_paths.bashrc"
source_opt_file "$CURRENTDIR/history.zshrc"
source_opt_file "$CURRENTDIR/common_aliases.shrc"
source_opt_file "$CURRENTDIR/temp.shrc"
source_opt_file "$CURRENTDIR/dev.shrc"
source_opt_file "$CURRENTDIR/theme.zshrc"

sysname=$(uname -s)
if [ "${sysname:0:9}" = "CYGWIN_NT" ]; then
  source_opt_file "$CURRENTDIR/windows.bashrc"
fi


# completion coloured like ls
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

zstyle ':completion:*' special-dirs true

