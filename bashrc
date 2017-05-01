# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# use zsh
if [ -f /bin/zsh ];then
  exec /usr/local/bin/zsh
fi
