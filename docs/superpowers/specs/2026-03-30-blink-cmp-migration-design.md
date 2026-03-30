# blink.cmp移行 設計ドキュメント

**日付:** 2026-03-30
**対象:** nvim/lua/kseki2/plugins/ 以下の補完関連設定

---

## 概要

nvim-cmpとその依存プラグイン群（9プラグイン）をblink.cmpに移行する。
blink.cmpはRust製の高速補完エンジンで、LSP/buffer/path/snippetソースを内蔵しており、複数のソースプラグインを1つに統合できる。

---

## 変更するファイル

### 削除
- `nvim/lua/kseki2/plugins/nvim-cmp.lua`

### 新規作成
- `nvim/lua/kseki2/plugins/blink-cmp.lua`

### 変更
- `nvim/lua/kseki2/lsp/default.lua` — `cmp_nvim_lsp` → `blink.cmp` のcapabilities取得に変更

---

## プラグイン変更の詳細

### 削除されるプラグイン（blink.cmpが内蔵）

| プラグイン | 役割 |
|---|---|
| `hrsh7th/nvim-cmp` | 補完エンジン本体 |
| `hrsh7th/cmp-buffer` | バッファソース |
| `hrsh7th/cmp-path` | パスソース |
| `hrsh7th/cmp-nvim-lsp` | LSPソース |
| `hrsh7th/cmp-cmdline` | コマンドラインソース |
| `onsails/lspkind.nvim` | アイコン表示 |
| `zbirenbaum/copilot-cmp` | Copilotソース（blink-copilotに置き換え） |
| `L3MON4D3/LuaSnip` | スニペットエンジン（blink内蔵に置き換え） |
| `saadparwaiz1/cmp_luasnip` | LuaSnipブリッジ |
### 追加されるプラグイン

| プラグイン | 役割 |
|---|---|
| `saghen/blink.cmp` | 補完エンジン本体（上記すべて内蔵） |
| `fang2hou/blink-copilot` | Copilotソース |
| `rafamadriz/friendly-snippets` | スニペット集（nvim-cmpから移管、blink経由でロード） |

### 変更しないプラグイン
- `zbirenbaum/copilot.lua` — blink-copilotの依存として残す（`suggestion`/`panel`は引き続きfalse）

---

## blink-cmp.lua の設計

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
      ["<CR>"]  = { "accept", "fallback" },  -- 未選択時は改行
      ["<C-k>"] = { "snippet_forward", "fallback" },  -- スニペット前方ジャンプ
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
          score_offset = 100,  -- Copilotを補完リストの先頭に
          async = true,
        },
      },
    },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      menu = { border = "rounded" },
      documentation = { auto_show = true, window = { border = "rounded" } },
    },
  },
}
```

---

## lsp/default.lua の変更

### 変更前
```lua
local capabilities = require("cmp_nvim_lsp").default_capabilities()
```

### 変更後
```lua
local capabilities = require("blink.cmp").get_lsp_capabilities()
```

---

## キーマップ対応表

| 現在 (nvim-cmp) | blink.cmp | 動作 |
|---|---|---|
| `<C-p>` | `select_prev` | 前の候補を選択 |
| `<C-n>` | `select_next` | 次の候補を選択 |
| `<CR>` (select=false) | `accept` + `fallback` | 選択中の候補を確定（未選択時は改行） |
| `<C-k>` (LuaSnipジャンプ) | `snippet_forward` | スニペット前方ジャンプ |

---

## スニペット

- `rafamadriz/friendly-snippets` はblink.cmpの `snippets` ソースが自動でロードする
- カスタムLuaスニペット（`~/dotfiles/.config/nvim/luasnippet/`）はLuaSnip依存のため**削除される**
  - 必要な場合は後日 `vim.snippet` フォーマットへの移行が必要

---

## 成功基準

- Neovim起動時にエラーなし
- LSP補完・buffer補完・path補完が動作する
- Copilot補完が補完リストに表示される
- `<CR>` で補完確定、未選択時は改行
- `<C-k>` でスニペットジャンプ
