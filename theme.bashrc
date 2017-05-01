#!/usr/bin/env bash


# colors, escaped in \[ \] or bash is confused about color position
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt_(Italiano)#Lista_di_colori_per_il_prompt_e_Bash
# https://unix.stackexchange.com/questions/56072/why-does-this-ps1-value-cause-unexpected-behaviour
readonly txtblk='\[\e[0;30m\]' # Nero - Regular
readonly txtred='\[\e[0;31m\]' # Rosso
readonly txtgrn='\[\e[0;32m\]' # Verde
readonly txtylw='\[\e[0;33m\]' # Giallo
readonly txtblu='\[\e[0;34m\]' # Blu
readonly txtpur='\[\e[0;35m\]' # Viola
readonly txtcyn='\[\e[0;36m\]' # Ciano
readonly txtwht='\[\e[0;37m\]' # Bianco
readonly txtrst='\[\e[0m\]'    # Text Reset

readonly bldblk='\[\e[1;30m\]' # Nero - Bold
readonly bldred='\[\e[1;31m\]' # Rosso
readonly bldgrn='\[\e[1;32m\]' # Verde
readonly bldylw='\[\e[1;33m\]' # Giallo
readonly bldblu='\[\e[1;34m\]' # Blu
readonly bldpur='\[\e[1;35m\]' # Viola
readonly bldcyn='\[\e[1;36m\]' # Ciano
readonly bldwht='\[\e[1;37m\]' # Bianco

readonly unkblk='\[\e[4;30m\]' # Nero - Underline
readonly undred='\[\e[4;31m\]' # Rosso
readonly undgrn='\[\e[4;32m\]' # Verde
readonly undylw='\[\e[4;33m\]' # Giallo
readonly undblu='\[\e[4;34m\]' # Blu
readonly undpur='\[\e[4;35m\]' # Viola
readonly undcyn='\[\e[4;36m\]' # Ciano
readonly undwht='\[\e[4;37m\]' # Bianco

readonly bakblk='\[\e[40m\]'   # Nero - Background
readonly bakred='\[\e[41m\]'   # Rosso
readonly badgrn='\[\e[42m\]'   # Verde
readonly bakylw='\[\e[43m\]'   # Giallo
readonly bakblu='\[\e[44m\]'   # Blu
readonly bakpur='\[\e[45m\]'   # Viola
readonly bakcyn='\[\e[46m\]'   # Ciano
readonly bakwht='\[\e[47m\]'   # Bianco

# otherwise tmux seems to have problems
if [ "$TERM" = "xterm" ]
then
  if [ "$COLORTERM" = "truecolor" ]
  then
    export TERM=xterm-256color
  fi
fi



theme_powerline() {
  local file="/usr/share/powerline/bindings/bash/powerline.sh"
  if [ -f "$file" ]; then
    export POWERLINE_BASH_CONTINUATION=1
    export POWERLINE_BASH_SELECT=1
    . "$file"
    return 0
  fi
  return 1
}

# modified from
# https://stackoverflow.com/questions/4133904/ps1-line-with-git-current-branch-and-colors
# https://bneijt.nl/blog/post/add-a-timestamp-to-your-bash-prompt/
theme_time_cvs(){
  local after_di="${LS_COLORS#*:di=0}"
  local dir_color="${after_di%%:*}m"
  local txtdircolor="\[\e[$dir_color\]"

  #local user_and_host="$txtgrn\u@\h"
  local user="$txtgrn\u${SSH_CLIENT:+$txtcyn@(ssh:\h)}"

  # trim, not based on lenght but number of subdirectories
  PROMPT_DIRTRIM=3
  local cur_location="$txtdircolor\w"

  local cur_time="$txtblu\t"

  local git_branch='$(LANG=en git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /)'
  local git_dirty;
  git_dirty="$(LANG=en git rev-parse 2>/dev/null && (git diff --no-ext-diff --quiet --exit-code 2> /dev/null || printf "* "))"

  local prompt_tail="$txtylw\\$ "

  if [ -f '/usr/lib/git-core/git-sh-prompt' ]; then
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWSTASHSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWUPSTREAM="auto"
    export GIT_PS1_SHOWCOLORHINTS=1
    . /usr/lib/git-core/git-sh-prompt
    PROMPT_COMMAND="__git_ps1 '${debian_chroot:+($debian_chroot)}$user $cur_location $cur_time$txtrst' '$prompt_tail$txtrst' "
  else
    local repo_color="$txtpur"
    local svn_stat='$(svn info 2>/dev/null | sed -ne '"'"'s#^URL: ##p'"'"' | egrep -o '"'"'[^/]+$'"'"')'

    PS1="${debian_chroot:+($debian_chroot)}$user $cur_location $cur_time $repo_color$git_branch$git_dirty$svn_stat$prompt_tail$txtrst"
  fi
}

# load theme
if theme_powerline; then
  :
else
  theme_time_cvs
fi
