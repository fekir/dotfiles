#!/usr/bin/env zsh

if [ "$TERM" = "xterm" ]
then
  if [ "$COLORTERM" = "truecolor" ]
  then
    export TERM=xterm-256color
  fi
fi

theme_powerline() {
  local file="/usr/share/powerline/bindings/zsh/powerline.zsh"
  if [ -f "$file" ]; then
    . "$file"
    return 0
  fi
  return 1
}

#http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
theme_time_git(){

  local user="%F{green}%n"
  local cur_location="%F{blue}%50<...<%~%<<" # truncates after 50 character with ..., and replace home wih ~
  local cur_time="%F{blue}%*"

  local prompt_tail="%F{yellow}%# "
  local last_color="%f"
  local check_previous_ret='%(?.%F{green}✓.%F{red}✗[%?])'

  PROMPT="$user $cur_location $cur_time $prompt_tail$last_color"
  RPROMPT="$check_previous_ret$git$svn_stat$last_color"
}

if theme_powerline; then
  :
else
  theme_time_git
fi

