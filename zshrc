#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Soruce Zsh functions.
for function in ~/.zsh/functions/*; do
  source $function
done

# completion
fpath=(~/.zsh/completion $fpath)

autoload -U compinit
compinit

# tmuxinator
source ~/.tmuxinator/tmuxinator.zsh

# Customize to your needs...
export PATH=$PATH:~/.local/bin
export PATH="/usr/local/bin:$PATH"

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls $HOME/.anyenv/envs`
do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
done

export EDITOR=vim

# History settings.
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000

setopt hist_ignore_all_dups # ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_dups     # 重複は除外
setopt hist_ignore_space    # スペースで始まるコマンド行はヒストリリストに追加しない
setopt hist_reduce_blanks   # 余分な空白は詰めて記録
setopt hist_save_no_dups    # 古いコマンドと同じものは無視
setopt hist_expand
setopt inc_append_history

setopt extended_glob        # 高機能なワイルドカード展開を使用する

bindkey -v

# ==== color =====
autoload -Uz colors
colors

# =====  alias =====
alias dc='docker-compose'
alias t='tmux'
alias update_submodule='git submodule update --init --recursive'
alias v='nvim'
#alias vim='nvim'

export PGDATA=/usr/local/var/postgres

# fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

function fzf-history-selection() {
  BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | fzf`
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fzf-history-selection
bindkey '^R' fzf-history-selection


function cdworktree() {
    # カレントディレクトリがGitリポジトリ上かどうか
    git rev-parse &>/dev/null
    if [ $? -ne 0 ]; then
        echo fatal: Not a git repository.
        return
    fi

    local selectedWorkTreeDir=`git worktree list | fzf | awk '{print $1}'`

    if [ "$selectedWorkTreeDir" = "" ]; then
        # Ctrl-C.
        return
    fi

    cd ${selectedWorkTreeDir}
}
