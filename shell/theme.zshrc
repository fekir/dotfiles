#!/usr/bin/env zsh

theme_minimal(){
  precmd () { }
  unset PROMPT
  unset PROMPT_COMMAND
  RPROMPT=''
  PS1='%(!.%F{red}#.%F{yellow}$)%f '
  PS2=' %F{blue}>%f '
  PS3=' %F{purple}?%f '
  PS4=' + '
  THEME_MINIMAL='true'
  export THEME_MINIMAL
}

theme_fix_mc(){
  RPROMPT=''
}

theme_powerline() {
  local file="/usr/share/powerline/bindings/zsh/powerline.zsh"
  if [ -f "$file" ]; then
    . "$file"
    unset THEME_MINIMAL
    return 0
  fi
  return 1
}

#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
theme_git(){
  autoload -Uz vcs_info
  setopt prompt_subst
  precmd() { vcs_info }
  theme_default
  local last_color="%f%E"
  zstyle ':vcs_info:git:*' formats 'branch:%b'
  RPROMPT="$RPROMPT%F{yellow}\$vcs_info_msg_0_$last_color"
}

theme_default(){
  local user="%F{green}%n"
  local cur_location="%B%F{blue}%50<...<%~%<<%b" # truncates after 50 character with ..., and replace home with ~

  local prompt_tail="%F{yellow}%# "
  local last_color="%f%E"
  local check_previous_ret='%(?..%F{red}X[%?])'

  PROMPT="$user $cur_location $prompt_tail$last_color"
  if [ "$+MC_SID" = "1" ] ; then PROMPT="%F{blue}MC $PROMPT"; fi
  if [[ ${SSH_TTY} ]]; then PROMPT="%F{magenta}[ssh:%M]%F{cyan} $PROMPT"; fi
  RPROMPT="$check_previous_ret$last_color"
  unset THEME_MINIMAL
}

theme_long_commands(){
  zmodload zsh/datetime
  autoload -Uz add-zsh-hook
  setopt prompt_subst

  preexec_time() {
    #command_to_exec="$1"
    preexec_timestamp=$EPOCHSECONDS
  }
  add-zsh-hook preexec preexec_time

  precmd_time(){
    local duration=$(($EPOCHSECONDS - ${preexec_timestamp-$EPOCHSECONDS}))
    ftime='';
    # whitelist interactive command like editor
    if [ $duration -gt 10 ]; then :;
      ftime="$(printf '%ds\n' $(($duration % 60)))";
      if [ $duration -gt 59 ]; then :;
        ftime="$(printf '%dm:%s' $(($duration % 3600 / 60)) $ftime)";
      fi
      if [ $duration -gt 3599 ]; then :;
        ftime="$(printf '%dh:%s' $(($duration / 3600)) $ftime)";
      fi
      ftime=" $ftime"
    fi
  }
  add-zsh-hook precmd precmd_time
  RPROMPT="$RPROMPT\$ftime"
}

# load theme
if [ "$THEME_MINIMAL" = "true" ]; then
  theme_minimal;
elif [ "$TERM_PROGRAM" != "vscode" ] && theme_powerline ; then
  :;
else
  # FIXME: find better way to integrate multiple hooks
  theme_git;
  theme_long_commands;
fi

if [ "$+MC_SID" = "1" ] ; then
  theme_fix_mc;
fi
