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

# Homebrew Ruby gems
set -x PATH /opt/homebrew/lib/ruby/gems/4.0.0/bin $PATH

set termguicolors

# vi mode
set -U fish_key_bindings fish_vi_key_bindings

# add ~/.local/bin
set -x PATH ~/.local/bin $PATH

# bat
set -x BAT_THEME Nord

# Claude code
set -x CLAUDE_ORG "kseki"

# alias
if test uname = Linux
    alias pbcopy 'xsel --clipboard --input'
    alias open gnome-www-browser
end

# FZF
set -x FZF_FIND_FILE_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_PREVIEW_FILE_COMMAND 'bat --theme=Nord --color=always --style=numbers --line-range=:100 {}'
set -x FZF_DEFAULT_OPTS
set --append FZF_DEFAULT_OPTS '--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1'
set --append FZF_DEFAULT_OPTS '--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1'
set --append FZF_DEFAULT_OPTS '--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac'
set --append FZF_DEFAULT_OPTS '--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
set --append FZF_DEFAULT_OPTS '--height 50%'
set --append FZF_DEFAULT_OPTS '--layout=reverse'
set --append FZF_DEFAULT_OPTS --border


alias gco 'git branch | fzf | xargs git checkout'
alias gbr 'git branch | fzf -m | xargs git branch -d'

if command -q fzf
    fzf --fish | source
end

# 端末間でヒストリーを共有
function history-merge --on-event fish_preexec
    history --save
    history --merge
end

# Github cli
eval (gh completion -s fish| source)

# For MacOS
if test (uname -s) = Darwin
    # ASDF configuration code
    if test -z $ASDF_DATA_DIR
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end
    
    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims

    if test -f ~/.asdf/installs/python/3.10.1/lib/python3.10/site-packages/powerline/bindings/fish/powerline-setup.fish
        source ~/.asdf/installs/python/3.10.1/lib/python3.10/site-packages/powerline/bindings/fish/powerline-setup.fish
    end

    # google cloud sdk
    if test -f (brew --prefix)/share/google-cloud-sdk/path.fish.inc
        source (brew --prefix)/share/google-cloud-sdk/path.fish.inc
    end

    # deno
    if command -q deno
        deno completions fish >~/.config/fish/completions/deno.fish
    end
end

# For Linux
if test (uname -s) = Linux
    # asdf
    source ~/.asdf/asdf.fish
end

# ghq + fzf: Ctrl+G で ghq repo に cd
function cd-repo
    cd (ghq list -p | fzf)
end
function fish_user_key_bindings
    bind -M default \cg cd-repo
    bind -M insert \cg cd-repo
end
