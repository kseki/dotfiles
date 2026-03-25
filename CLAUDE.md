# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository for macOS. Config files are symlinked from `~/.dotfiles` to `$HOME` via `install.sh`.

## Installation

```sh
# Clones to ~/.dotfiles and symlinks all dotfiles to $HOME
./install.sh
```

## Architecture

### Neovim (`nvim/`)

The active config uses `kseki2` namespace with lazy.nvim as the plugin manager. Entry point: `nvim/init.lua` → `kseki2.config.lazy`.

- `nvim/lua/kseki2/config/lazy.lua` — lazy.nvim bootstrap, leader key (`<Space>`), loads plugins from `kseki2.plugins`
- `nvim/lua/kseki2/core/` — options, keymaps, autocmds
- `nvim/lua/kseki2/plugins/` — individual plugin configs (one file per plugin)
- `nvim/lua/kseki2/lsp/` — LSP server configs with shared helper (`libs/_set_lsp.lua`)
- `nvim/lua/kseki/` and `nvim/lua/LazyVim/` — legacy configs (commented out in init.lua), kept for reference

### Shell (`zshrc`, `zsh/`)

Zsh with Prezto framework. Vi keybindings (`bindkey -v`). Custom functions in `zsh/functions/`, completions in `zsh/completion/`. Uses anyenv for language version management.

### Git (`gitconfig`, `git/`)

- Uses delta for diffs (side-by-side)
- Core editor: nvim
- Repo management via ghq (`root = ~/src`)
- Custom git template with pre-push hook and PR/issue templates in `git/git_template/`

### Terminal & Window Management

- **Alacritty** (`alacritty/`) — terminal emulator config with theme support (Dracula, Nordfox)
- **tmux** (`tmux.conf`, `tmux/`) — prefix `C-a`, vi copy mode, TPM for plugins, OS-specific configs
- **yabai** (`yabairc`) + **skhd** (`skhdrc`) — tiling window manager and hotkey daemon

## Workflow

- GitHub Flow（mainブランチから直接featureブランチを切り、PRでマージする）を使用する
- 並列セッション実行時は`git worktree`を使い、作業ディレクトリの干渉を避ける

## Conventions

- Commit messages are in Japanese with conventional prefix (feat/chore/fix)
- Neovim plugins: one Lua file per plugin in `nvim/lua/kseki2/plugins/`
- LSP servers: one file per server in `nvim/lua/kseki2/lsp/`, using the `_set_lsp` helper
