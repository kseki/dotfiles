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

# completion alias
compdef g=git

# Customize to your needs...
export PATH=$PATH:~/.local/bin

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export EDITOR=vim

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

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward


# ==== color =====
autoload -Uz colors
colors

# =====  alias =====
alias vim='nvim'
alias vi='vim'
