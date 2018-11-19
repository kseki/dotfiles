set --export EDITOR vm
set --export MANPATH /usr/share/man $MANPATH

# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set --export PATH ~/.local/bin $PATH

# linuxbrew
set --export PATH /home/linuxbrew/.linuxbrew/bin $PATH
set --export PATH /home/linuxbrew/.linuxbrew/sbin $PATH
set --export MANPATH /home/linuxbrew/.linuxbrew/share/man $MANPATH
set --export INFOPATH /home/linuxbrew/.linuxbrew/share/info $INFOPATH

# anyenv
set --export PATH ~/.anyenv/bin $PATH
for dir in (ls ~/.anyenv/envs)
set --export  PATH ~/.anyenv/envs/$dir/bin $PATH
set --export PATH ~/.anyenv/envs/$dir/shims $PATH
end

# FZF
set --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set --export FZF_DEFAULT_OPTS '--height 40 --reverse --inline-info'
set --export FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND

# alias
alias pbcopy 'xsel --clipboard --input'
alias gco 'git branch | fzf | xargs git checkout'

#function fish_user_key_bindings
#  bind \cl clear
#  bind -M default \$ end-of-line accept-autosuggestion
#end
#fish_vi_key_bindings
#set -g fish_escape_delay_ms 10

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

