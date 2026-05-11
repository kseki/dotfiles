# プロジェクトローカルNeovim設定 設計

## 目的

特定のディレクトリ（プロジェクトルート）に置いたファイルから、Neovimの設定・LSP/formatter上書き・スニペットをそのプロジェクト限定で適用できるようにする。

## 用途と非用途

- **対象**: Lua設定（オプション、キーマップ、autocmd）、LSP/conform.nvimのformatter上書き、blink.cmpで使うスニペット
- **対象外**: 環境変数やシェルコマンド注入、プロジェクトルート自動検出（CWDがプロジェクトルートである前提）

## ファイル配置

プロジェクト側:

```
<project-root>/
├── .nvim.lua             # exrcで自動読み込みされるブートストラップ（数行）
└── .nvim/
    ├── init.lua          # プロジェクト固有のLua設定エントリ
    └── snippets/
        ├── package.json  # friendly-snippets互換マニフェスト
        └── snippets/
            └── <filetype>.json
```

dotfiles側の変更:

- `nvim/lua/kseki2/core/options.lua` に `vim.o.exrc = true` を追加
- `nvim/lua/kseki2/plugins/blink-cmp.lua` でCWDの `.nvim/snippets` を友達スニペットの検索パスに動的追加
- `nvim/README.md` を新規作成し、プロジェクト固有設定の使い方を記載

## アーキテクチャ

```
nvim 起動
  └─ ~/.dotfiles/nvim/init.lua
       └─ kseki2.config.lazy
            ├─ vim.o.exrc = true
            └─ lazy.nvim setup
                 └─ blink.cmp 初期化
                      └─ CWDの .nvim/snippets を検出して friendly-snippets パスへ追加
  └─ Neovim 標準の exrc 機構
       └─ <CWD>/.nvim.lua をロード（未信頼なら確認）
            └─ dofile('<CWD>/.nvim/init.lua')
                 └─ プロジェクト固有のオプション/LSP/formatter上書き
```

## データフロー（読み込み順）

1. `nvim` 起動
2. `~/.dotfiles/nvim/init.lua` → `kseki2.config.lazy` がロードされる
3. options.lua にて `vim.o.exrc = true` がセットされる
4. lazy.nvim のセットアップが走り、blink.cmp の初期化処理内でCWDの `.nvim/snippets` を検査し、存在すれば `friendly-snippets` の検索パスに足す
5. Neovim 標準の exrc 機構が `<CWD>/.nvim.lua` を検出。未信頼の場合は `:trust` 待ち、信頼済みなら実行
6. `.nvim.lua` が `.nvim/init.lua` を `dofile` する
7. `.nvim/init.lua` がプロジェクト固有の `vim.opt` / `vim.lsp.config` / conform 設定を適用

## コンポーネント詳細

### `.nvim.lua`（プロジェクト側、テンプレート）

最小ブートストラップ。実コードは `.nvim/init.lua` に置く。

```lua
local entry = vim.fn.getcwd() .. "/.nvim/init.lua"
if vim.uv.fs_stat(entry) then
  dofile(entry)
end
```

### `.nvim/init.lua`（プロジェクト側、自由記述）

プロジェクト固有のLuaを直接書く。例:

```lua
-- インデントをこのプロジェクトだけ4に
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- LSP 上書き
vim.lsp.config('lua_ls', { settings = { Lua = { ... } } })

-- formatter 上書き
require('conform').formatters_by_ft.lua = { 'stylua' }
```

### `.nvim/snippets/`（プロジェクト側）

`friendly-snippets` と同じパッケージ規格。`package.json` で contributions を宣言し、`snippets/<filetype>.json` にVSCode形式のスニペットを書く。

### dotfiles: `options.lua`

`vim.o.exrc = true` を追加するのみ。`vim.o.secure` は Neovim では存在しないため設定不要（Neovim は信頼ハッシュベース）。

### dotfiles: `blink-cmp.lua`

`sources.providers.snippets.opts.search_paths` にデフォルトの friendly-snippets パスに加えて、CWDの `.nvim/snippets` を条件付きで追加する。

具体的な実装イメージ（実装段階で blink.cmp の現行API仕様を確認すること）:

```lua
local function project_snippet_paths()
  local p = vim.fn.getcwd() .. "/.nvim/snippets"
  if vim.uv.fs_stat(p) then
    return { p }
  end
  return {}
end
```

これを blink.cmp の snippets ソースのオプションに食わせる。

### dotfiles: `nvim/README.md`（新規）

このリポジトリのNeovim設定の概要に加えて、プロジェクトローカル設定の使い方を記載する。最低限カバーする内容:

- 何ができるか（Lua設定/LSP/formatter/スニペット上書き）
- 必要なファイル配置（`.nvim.lua` + `.nvim/`）
- 信頼確認のフロー（`:trust` コマンド、信頼ハッシュの保存先）
- スニペットの書き方（VSCode形式JSONのフォーマット例、`package.json` のサンプル）
- サンプルプロジェクトとして1個の最小例

## エラー処理 & 既存設定との競合

- `.nvim.lua` が無い: 何もしない（通常起動）
- 未信頼の `.nvim.lua`: Neovim が確認を出す。`:trust` で許可
- `.nvim/init.lua` が無い: ブートストラップ側で `fs_stat` チェック済みのためスキップ
- `.nvim/init.lua` のエラー: `dofile` は例外を投げるため、ブートストラップ側で `pcall` で囲む（実装時に追加）
- スニペット重複: `friendly-snippets` と同名トリガがある場合、blink.cmp の `search_paths` の順序で先勝ち。プロジェクト側を優先したいなら CWD パスを先頭に追加する
- LSP 設定の競合: `vim.lsp.config()` は名前付きでマージされるため、プロジェクト側の設定が後勝ちになる（意図通り）

## 信頼モデル

- Neovim 0.9+ の `:trust` を使う。信頼ハッシュは `~/.local/state/nvim/trust` に保存される
- 信頼対象は `.nvim.lua` のみ。`.nvim/init.lua` 以下を変更しても再確認は走らない
- このトレードオフは合意済み（過剰な再確認の煩雑さを避けるため）

## テスト方針

- 自動テストなし
- 手動: テスト用プロジェクトを2つ作り、それぞれ違う `.nvim.lua` / `.nvim/snippets/` を置いて
  - インデント設定が切り替わるか
  - スニペットが追加されるか
  - 別ディレクトリへ `cd` して `nvim` 起動し直すと切り替わるか
  - `:trust` のフローが意図通りか

## 将来の拡張余地（今回はやらない）

- プロジェクトルート自動検出（git rootベース）
- `DirChanged` での動的リロード（現状は再起動前提）
- 自動テスト（busted等の導入は別タスク）
