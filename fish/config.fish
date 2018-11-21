set --export EDITOR vim
set --export MANPATH /usr/share/man $MANPATH

# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set --export PATH ~/.local/bin $PATH

# fzf
set --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set --export FZF_DEFAULT_OPTS '--height 40 --reverse --inline-info'
set --export FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND

# alias
alias pbcopy 'xsel --clipboard --input'
alias gco 'git branch | fzf | xargs git checkout'
alias open 'gnome-www-browser'

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# anyenv
. ~/.config/fish/anyenv.fish
