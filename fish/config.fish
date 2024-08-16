set fish_greeting
set -x LANG 'en_US.UTF-8'
set -x EDITOR nvim
set -x MANPATH /usr/share/man $MANPATH
set -x XDG_CONFIG_HOME $HOME/.config

set -x PGDATA /usr/local/var/postgres

set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x JAVA_HOME $HOME/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
set -x PATH $ANDROID_HOME/platform-tools $PATH
set -x PATH $ANDROID_HOME/tools $PATH
set -x PATH $ANDROID_HOME/tools/bin $PATH
set -x PATH $ANDROID_HOME/emulator $PATH

set -x PATH /usr/local/sbin $PATH

set termguicolors

# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set -x PATH ~/.local/bin $PATH

# bat
set -x BAT_THEME 'Dracula'

# alias
if test uname = 'Linux'
  alias pbcopy 'xsel --clipboard --input'
  alias open 'gnome-www-browser'
end

# FZF
set -x FZF_FIND_FILE_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_PREVIEW_FILE_COMMAND 'bat --theme=dracula --color=always --style=numbers --line-range=:100 {}'
set -x FZF_DEFAULT_OPTS
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

# For MacOS
if test (uname -s) = "Darwin"
  # asdf
  source (brew --prefix asdf)/libexec/asdf.fish
  source ~/.asdf/installs/python/3.10.1/lib/python3.10/site-packages/powerline/bindings/fish/powerline-setup.fish

  # google cloud sdk
  source (brew --prefix)/share/google-cloud-sdk/path.fish.inc

  # deno
  deno completions fish > ~/.config/fish/completions/deno.fish
end

# For Linux
if test (uname -s) = "Linux"
  # asdf
  source ~/.asdf/asdf.fish
end


function fish_user_key_bindings
  bind \cs gco
end
