export LANG=ja_JP.UTF-8

autoload -Uz compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt extended_glob
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt print_eight_bit

# for zsh-completions
plugins=(git ruby osx bundler brew rails emoji-clock)
fpath=(/usr/local/share/zsh-completions $fpath)

# export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"
export PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
