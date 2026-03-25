# dotfiles

macOS 用の個人 dotfiles リポジトリ。

## セットアップ

```sh
git clone git@github.com:kseki/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# 各 dotfile を $HOME にシンボリックリンク
./install.sh
```

## 構成

| ディレクトリ / ファイル | 説明 |
|---|---|
| `nvim/` | Neovim 設定（lazy.nvim + `kseki2` namespace） |
| `zshrc`, `zsh/` | Zsh 設定（Prezto, vi keybindings） |
| `fish/` | Fish shell 設定 |
| `gitconfig`, `git/` | Git 設定（delta, ghq, テンプレート） |
| `alacritty/` | Alacritty ターミナル設定 |
| `ghostty/` | Ghostty ターミナル設定 |
| `tmux.conf`, `tmux/` | tmux 設定（prefix: `C-a`, TPM） |
| `lazygit/` | Lazygit 設定 |
| `vimrc`, `vim/` | Vim 設定 |

## Neovim

エントリポイント: `nvim/init.lua` → `kseki2.config.lazy`

- `nvim/lua/kseki2/config/` — lazy.nvim ブートストラップ、リーダーキー（`<Space>`）
- `nvim/lua/kseki2/core/` — options, keymaps, autocmds
- `nvim/lua/kseki2/plugins/` — プラグイン設定（1ファイル1プラグイン）
- `nvim/lua/kseki2/lsp/` — LSP サーバー設定
