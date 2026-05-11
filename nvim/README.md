# Neovim 設定

このディレクトリは個人用 Neovim 設定。lazy.nvim ベースで `kseki2` 名前空間を使用する。

## エントリポイント

`init.lua` → `lua/kseki2/config/lazy.lua`

- `lua/kseki2/core/` — options, keymaps, autocmds
- `lua/kseki2/plugins/` — プラグイン1ファイル1設定
- `lua/kseki2/lsp/` — LSP サーバ設定（`libs/_set_lsp.lua` 経由）

## プロジェクトローカル設定

プロジェクトルートに以下のファイル群を置くと、そのディレクトリで `nvim` を起動したときだけ追加の設定/スニペットが適用される。

### ファイル配置

```
<project-root>/
├── .nvim.lua                       # exrcブートストラップ
└── .nvim/
    ├── init.lua                    # プロジェクト固有のLua設定
    └── snippets/
        ├── package.json            # friendly-snippets互換マニフェスト
        └── <filetype>.json         # VSCode形式スニペット
```

### `.nvim.lua`（ブートストラップ）

Neovim 標準の `exrc` 機構で自動読み込みされる。中身は `.nvim/init.lua` を呼ぶだけにしておく:

```lua
local entry = vim.fn.getcwd() .. "/.nvim/init.lua"
if (vim.uv or vim.loop).fs_stat(entry) then
  local ok, err = pcall(dofile, entry)
  if not ok then
    vim.notify("project-local config error: " .. tostring(err), vim.log.levels.ERROR)
  end
end
```

### `.nvim/init.lua`（プロジェクト固有設定）

通常の Lua として何でも書ける。例:

```lua
-- インデントをこのプロジェクトだけ4スペースに
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- LSP サーバ設定の上書き
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- conform.nvim の formatter 上書き
require("conform").formatters_by_ft.lua = { "stylua" }
```

### スニペット

friendly-snippets と同じ VSCode 形式。`.nvim/snippets/package.json` で contribute 宣言する:

```jsonc
{
  "name": "project-snippets",
  "contributes": {
    "snippets": [
      { "language": "lua", "path": "./lua.json" },
      { "language": ["typescript", "typescriptreact"], "path": "./ts.json" }
    ]
  }
}
```

各 `<lang>.json` の中身は VSCode 規格:

```json
{
  "Console Log": {
    "prefix": "clog",
    "body": ["console.log(\"${1:msg}\", ${2:value});"],
    "description": "console.log with placeholder"
  }
}
```

プロジェクト側のスニペットは検索パスの先頭に挿入されるため、friendly-snippets と同名トリガがある場合はプロジェクト側が優先される。

### 信頼モデル

`.nvim.lua` を含むディレクトリで初めて `nvim` を起動すると、Neovim から信頼確認のプロンプトが出る。許可する場合:

```
:trust
```

信頼ハッシュは `~/.local/state/nvim/trust` に保存される。`.nvim.lua` 自体を編集すると次回起動時にもう一度プロンプトが出る（`.nvim/init.lua` 以下の変更では出ない）。

### 制限事項

- プロジェクトルートの自動検出はしない。CWD がプロジェクトルートである前提。`cd <project>` してから `nvim` を起動する
- `:cd` でディレクトリを変えてもスニペットの検索パスは切り替わらない（再起動が必要）
- スニペットは VSCode 形式 JSON のみサポート（blink.cmp の仕様）
