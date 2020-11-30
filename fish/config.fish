set --export EDITOR nvim
set --export MANPATH /usr/share/man $MANPATH
set --export TERM 'xterm-256color'
set --export XDG_BASE_HOME '~/.config'
set --export ANDROID_SDK_ROOT /Users/kota/Library/Android/sdk

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

# FZF
alias gco 'git branch | fzf | xargs git checkout'
alias gbr 'git branch | fzf -m | xargs git branch -d'

set -U FZF_LEGACY_KEYBINDINGS 0

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# anyenv
# set -Ux fish_user_paths $HOME/.anyenv/bin $fish_user_paths
# status --is-interactive; and source (anyenv init -|psub)
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)
