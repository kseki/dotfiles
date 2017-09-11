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

# Customize to your needs...
export PATH=$PATH:~/.local/bin

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

export EDITOR=vim

# コメンド履歴
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt hist_ignore_dups # 重複は除外
setopt share_history    # 履歴を共有する

setopt extended_glob    # 高機能なワイルドカード展開を使用する

# ==== color =====
autoload -Uz colors
colors


# =====  alias =====
alias vim='nvim'
alias vi='vim'
