set -x EDITOR vim
set -x TERM xterm-256color
set -x PATH /usr/local/bin $PATH
set -gx VIM /usr/local/bin/nvim
set -gx VIMRUNTIME /usr/local/Cellar/neovim/0.1.7/share/nvim/runtime

# anyenv
set -x PATH $PATH ~/.anyenv/bin

for dir in (ls ~/.anyenv/envs)
  set -x  PATH $PATH ~/.anyenv/envs/$dir/bin
  set -x PATH $PATH ~/.anyenv/envs/$dir/shims
end

. $HOME/.anyenv/completions/anyenv.fish
anyenv init - > /dev/null

alias vim 'nvim'

for file in ~/.config/fish/conf.d/*.fish
  source $file
end

set HISTCONTROL ignoreboth
set HISTIGNORE  pwd:ls:history
