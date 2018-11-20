set --export EDITOR vim
#set -x TERM xterm-256color
set -x PATH /usr/local/bin $PATH
#set -gx VIM /usr/local/bin/nvim
#set -gx VIMRUNTIME /usr/local/Cellar/neovim/0.1.7/share/nvim/runtime

# anyenv
set --export PATH $PATH ~/.anyenv/bin

for dir in (ls ~/.anyenv/envs)
  set --export PATH ~/.anyenv/envs/$dir/bin $PATH
  set --export PATH ~/.anyenv/envs/$dir/shims $PATH
end

set HISTCONTROL ignoreboth
set HISTIGNORE  pwd:ls:history

set --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set --export FZF_DEFAULT_OPTS '--height 40 --reverse --inline-info'

. ~/.config/fish/anyenv.fish
