set fish_greeting
set --export LANG 'ja_JP.UTF-8'
set --export EDITOR nvim
set --export MANPATH /usr/share/man $MANPATH
set --export XDG_BASE_HOME '~/.config'
set --export PGDATA /usr/local/var/postgres

set --export ANDROID_HOME $HOME/Library/Android/sdk
set --export JAVA_HOME $HOME/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
set --export PATH $ANDROID_HOME/platform-tools $PATH
set --export PATH $ANDROID_HOME/tools $PATH
set --export PATH $ANDROID_HOME/tools/bin $PATH
set --export PATH $ANDROID_HOME/emulator $PATH
set termguicolors


# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set --export PATH ~/.local/bin $PATH

# bat
set --export BAT_THEME 'Dracula'

# alias
if test uname = 'Linux'
  alias pbcopy 'xsel --clipboard --input'
  alias open 'gnome-www-browser'
end

# FZF
set --export FZF_FIND_FILE_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set --export FZF_PREVIEW_FILE_COMMAND 'bat --color=always --style=numbers --line-range=:100 {}'
set --export --universal FZF_DEFAULT_OPTS
set --append FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9'
set --append FZF_DEFAULT_OPTS '--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9'
set --append FZF_DEFAULT_OPTS '--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6'
set --append FZF_DEFAULT_OPTS '--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
set --append FZF_DEFAULT_OPTS '--height 50%'
set --append FZF_DEFAULT_OPTS '--layout=reverse'
set --append FZF_DEFAULT_OPTS '--border'


alias gco 'git branch | fzf | xargs git checkout'
alias gbr 'git branch | fzf -m | xargs git branch -d'

set -U FZF_LEGACY_KEYBINDINGS 0

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
  history --save
  history --merge
end

# Github cli
eval (gh completion -s fish| source)

# asdf
source (brew --prefix asdf)/asdf.fish

#starship
starship init fish | source
