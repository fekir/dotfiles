#!/usr/bin/env zsh

# main.zshrc: executed by zsh for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
bindkey '^R' history-incremental-search-backward

# Enable Ctrl+x,e like on bash
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

CURRENTDIR=${0:h}

# not optional, defines source_opt_file
. "$CURRENTDIR/common_functions.shrc"

detect_term

# zsh settings
#  completion
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _complete _ignored _approximate
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

unsetopt autocd
unsetopt beep

setopt extendedglob
setopt nomatch
setopt interactivecomments
# disable ctrl+s
stty -ixon

# write ^C when pressing ctrl+c, like bash
TRAPINT() { print -P -n -- '%F{red}\^C%f';return 130;}

# optionals
source_opt_file "$CURRENTDIR/history.zshrc"
source_opt_file "$CURRENTDIR/common_aliases.shrc"
source_opt_file "$CURRENTDIR/prog_settings.shrc"
source_opt_file "$CURRENTDIR/theme.zshrc"

sysname=$(uname -s)
if [ "${sysname:0:9}" = "CYGWIN_NT" ] || [ "${sysname:0:10}" = "MINGW32_NT" ] || [ "${sysname:0:10}" = "MINGW64_NT" ] || [ "${sysname:0:7}" = "MSYS_NT" ]; then :;
  source_opt_file "$CURRENTDIR/windows.shrc"
fi

source_opt_file '/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'
zstyle ':completion:*:hosts' hosts # do not read host file, as most entries are blacklist (see https://github.com/ohmyzsh/ohmyzsh/issues/7397)

# update path
test "${PATH#*$HOME/bin:}" != "$PATH" || PATH="$HOME/bin:$PATH"
