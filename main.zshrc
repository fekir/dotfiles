#!/usr/bin/env zsh

# main.zshrc: executed by zsh for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Fortune message
if [[ "$TERM" = screen* ]] || [ "$THEME_MINIMAL" = "true" ]; ; then
  :
else
  message=$(fortune -s 2>/dev/null || echo "Welcome")
  cowsay -f duck -- "$message" 2>/dev/null;
fi

autoload -U select-word-style
select-word-style bash
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

detect_term

# optionals
source_opt_file "$CURRENTDIR/xdg_paths.bashrc"
source_opt_file "$CURRENTDIR/history.zshrc"
source_opt_file "$CURRENTDIR/common_aliases.shrc"
source_opt_file "$CURRENTDIR/temp.shrc"
source_opt_file "$CURRENTDIR/dev.shrc"
source_opt_file "$CURRENTDIR/theme.zshrc"

sysname=$(uname -s)
if [ "${sysname:0:9}" = "CYGWIN_NT" ]; then
  source_opt_file "$CURRENTDIR/windows.shrc"
fi

# zsh settings
#  completion
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete _ignored _approximate
autoload -Uz compinit
compinit


unsetopt autocd
unsetopt beep

setopt extendedglob
setopt nomatch

# disable ctrl+s
stty -ixon

# write ^C when pressing ctrl+c, like bash
TRAPINT() { print -P -n -- '%F{red}\^C%f';return 130;}
