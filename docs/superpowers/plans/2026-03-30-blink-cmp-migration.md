# blink.cmp移行 実装プラン

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** nvim-cmpとその依存9プラグインをblink.cmpに移行し、補完設定をシンプルにする

**Architecture:** nvim-cmp.luaを削除してblink-cmp.luaを新規作成。LSP capabilities取得をcmp_nvim_lsp→blink.cmpに変更。Copilot補完はblink-copilotソース経由で維持。

**Tech Stack:** Lua, lazy.nvim, blink.cmp (saghen/blink.cmp), blink-copilot (fang2hou/blink-copilot), copilot.lua (zbirenbaum/copilot.lua)

---

### Task 1: blink-cmp.lua を作成する

**Files:**
- Create: `nvim/lua/kseki2/plugins/blink-cmp.lua`

- [ ] **Step 1: blink-cmp.lua を新規作成する**

`nvim/lua/kseki2/plugins/blink-cmp.lua` を以下の内容で作成する：

```lua
return {
	"saghen/blink.cmp",
	dependencies = {
		"fang2hou/blink-copilot",
		"zbirenbaum/copilot.lua",
		"rafamadriz/friendly-snippets",
	},
	version = "*",
	opts = {
		keymap = {
			preset = "default",
			["<CR>"] = { "accept", "fallback" },
			["<C-k>"] = { "snippet_forward", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "copilot", "lsp", "path", "snippets", "buffer" },
			providers = {
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},
		completion = {
			accept = { auto_brackets = { enabled = true } },
			menu = { border = "rounded" },
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
		},
	},
}
```

- [ ] **Step 2: コミット**

```bash
git add nvim/lua/kseki2/plugins/blink-cmp.lua
git commit -m "feat: blink-cmp.luaを追加"
```

---

### Task 2: lsp/default.lua を更新する

**Files:**
- Modify: `nvim/lua/kseki2/lsp/default.lua`

- [ ] **Step 1: capabilities取得をblink.cmpに変更する**

`nvim/lua/kseki2/lsp/default.lua` を以下のように変更する：

変更前:
```lua
local function default_config(server)
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	local util = require("kseki2.libs._set_lsp")

	vim.lsp.config(server, {
		on_attach = util.on_attach,
		capabilities = capabilities,
	})
end

return default_config
```

変更後:
```lua
local function default_config(server)
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	local util = require("kseki2.libs._set_lsp")

	vim.lsp.config(server, {
		on_attach = util.on_attach,
		capabilities = capabilities,
	})
end

return default_config
```

- [ ] **Step 2: コミット**

```bash
git add nvim/lua/kseki2/lsp/default.lua
git commit -m "fix: LSP capabilitiesをblink.cmp経由に変更"
```

---

### Task 3: nvim-cmp.lua を削除する

**Files:**
- Delete: `nvim/lua/kseki2/plugins/nvim-cmp.lua`

- [ ] **Step 1: nvim-cmp.lua を削除する**

```bash
git rm nvim/lua/kseki2/plugins/nvim-cmp.lua
```

- [ ] **Step 2: コミット**

```bash
git commit -m "chore: nvim-cmp.luaを削除（blink.cmpに移行）"
```

---

### Task 4: Neovimで動作確認する

**Files:** なし（手動検証）

- [ ] **Step 1: Neovimを起動してプラグインをインストールする**

Neovimを起動し、lazy.nvimが新しいプラグインをインストールするのを待つ：

```
nvim
```

起動時に `:Lazy` を実行してblink.cmpとblink-copilotがインストールされていることを確認する。

- [ ] **Step 2: 補完が動作することを確認する**

適当なLuaファイル（例: `nvim/lua/kseki2/plugins/blink-cmp.lua`）を開き、インサートモードで以下を確認する：

1. `require("` と入力→ LSP補完候補が表示される
2. `<C-n>` / `<C-p>` で候補を移動できる
3. `<CR>` で選択した候補が確定される
4. Copilot候補が補完リストの先頭付近に表示される（要Copilot認証済み環境）

- [ ] **Step 3: スニペット展開を確認する**

Luaファイルでfriendly-snippetsに含まれるスニペットトリガーを入力し（例: `fun`）、補完リストにスニペット候補が表示されることを確認する。`<C-k>` でジャンプできることを確認する。

- [ ] **Step 4: LSPが正常に動作することを確認する**

Luaファイルで `:LspInfo` を実行し、`lua_ls` が起動していることを確認する。定義ジャンプ（`gd`）や補完が機能することを確認する。

- [ ] **Step 5: エラーがないことを確認する**

`:checkhealth blink` を実行してエラーがないことを確認する。

起動時の `nvim.log` にblink関連のエラーがないことも確認する（存在する場合）。

- [ ] **Step 6: 最終コミット（問題なければ）**

```bash
git add docs/superpowers/specs/2026-03-30-blink-cmp-migration-design.md
git add docs/superpowers/plans/2026-03-30-blink-cmp-migration.md
git commit -m "docs: blink.cmp移行の設計書・実装プランを追加"
```
