set --export EDITOR vim
set --export MANPATH /usr/share/man $MANPATH
set --export TERM 'xterm-256color'

# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set --export PATH ~/.local/bin $PATH

set --export FZF_FIND_FILE_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set --export FZF_DEFAULT_OPTS '--height 50% --layout=reverse --border'
set --export FZF_PREVIEW_FILE_COMMAND 'head -n 10'

# alias
if test uname = 'Linux'
  alias pbcopy 'xsel --clipboard --input'
  alias open 'gnome-www-browser'
end
alias gco 'git branch | fzf | xargs git checkout'

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# anyenv
. ~/.config/fish/anyenv.fish
