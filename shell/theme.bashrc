#!/usr/bin/env bash


# colors, escaped in \[ \] or bash is confused about color position
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt_(Italiano)#Lista_di_colori_per_il_prompt_e_Bash
# https://unix.stackexchange.com/questions/56072/why-does-this-ps1-value-cause-unexpected-behaviour
txtblk='\[\e[0;30m\]' # Nero - Regular
txtred='\[\e[0;31m\]' # Rosso
txtgrn='\[\e[0;32m\]' # Verde
txtylw='\[\e[0;33m\]' # Giallo
txtblu='\[\e[0;34m\]' # Blu
txtpur='\[\e[0;35m\]' # Viola
txtcyn='\[\e[0;36m\]' # Ciano
txtwht='\[\e[0;37m\]' # Bianco
txtrst='\[\e[0m\]'    # Text Reset

bldblk='\[\e[1;30m\]' # Nero - Bold
bldred='\[\e[1;31m\]' # Rosso
bldgrn='\[\e[1;32m\]' # Verde
bldylw='\[\e[1;33m\]' # Giallo
bldblu='\[\e[1;34m\]' # Blu
bldpur='\[\e[1;35m\]' # Viola
bldcyn='\[\e[1;36m\]' # Ciano
bldwht='\[\e[1;37m\]' # Bianco

unkblk='\[\e[4;30m\]' # Nero - Underline
undred='\[\e[4;31m\]' # Rosso
undgrn='\[\e[4;32m\]' # Verde
undylw='\[\e[4;33m\]' # Giallo
undblu='\[\e[4;34m\]' # Blu
undpur='\[\e[4;35m\]' # Viola
undcyn='\[\e[4;36m\]' # Ciano
undwht='\[\e[4;37m\]' # Bianco

bakblk='\[\e[40m\]'   # Nero - Background
bakred='\[\e[41m\]'   # Rosso
badgrn='\[\e[42m\]'   # Verde
bakylw='\[\e[43m\]'   # Giallo
bakblu='\[\e[44m\]'   # Blu
bakpur='\[\e[45m\]'   # Viola
bakcyn='\[\e[46m\]'   # Ciano
bakwht='\[\e[47m\]'   # Bianco

theme_minimal(){
  unset PROMPT_COMMAND
  PS1="$txtylw\\\$$txtrst "
  PS2=" $txtblu>$txtrst "
  local locpur=$'\e[1;35m'
  local loccyano=$'\e[1;36m'
  local locreset=$'\e[m'
  PS3=" ${locpur}?${locreset} "
  PS4=" ${loccyano}+${locreset} "
  THEME_MINIMAL='true'
  export THEME_MINIMAL
}

theme_powerline() {
  local file="/usr/share/powerline/bindings/bash/powerline.sh"
  if [ -f "$file" ]; then
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    . "$file"
    unset THEME_MINIMAL
    return 0
  fi
  return 1
}

# modified from
# https://stackoverflow.com/questions/4133904/ps1-line-with-git-current-branch-and-colors
theme_cvs(){
  local after_di="${LS_COLORS#*:di=0}"
  local dir_color="${after_di%%:*}m"
  local txtdircolor="\[\e[$dir_color\]"

  #local user_and_host="$txtgrn\u@\h"
  local user="$txtgrn\u${SSH_CLIENT:+$txtcyn@(ssh:\h)}"

  # trim, not based on length but number of subdirectories
  PROMPT_DIRTRIM=3
  local cur_location="$txtdircolor\w"

  local git_branch='$(LANG=en git branch 2> /dev/null | "grep" -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)'

  local prompt_tail="$txtylw\\$ "

  if [ -f '/usr/lib/git-core/git-sh-prompt' ]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=1
    . /usr/lib/git-core/git-sh-prompt
    PROMPT_COMMAND="__git_ps1 '${debian_chroot:+($debian_chroot)}$user $cur_location $txtrst' '$prompt_tail$txtrst' "
  else
    local repo_color="$txtpur"
    local svn_stat='$(svn info 2>/dev/null | sed -ne '"'"'s#^URL: ##p'"'"' | egrep -o '"'"'[^/]+$'"'"')'

    PS1="${debian_chroot:+($debian_chroot)}$user $cur_location $repo_color$git_branch$git_dirty$svn_stat$prompt_tail$txtrst"
  fi
  unset THEME_MINIMAL
}

# load theme
if [ "$THEME_MINIMAL" = "true" ]; then
  theme_minimal;
elif [ "$TERM_PROGRAM" != "vscode" ] && theme_powerline ; then
  :;
else
  theme_cvs;
fi
