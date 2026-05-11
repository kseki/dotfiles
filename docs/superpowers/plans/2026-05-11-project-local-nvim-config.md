# プロジェクトローカルNeovim設定 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** プロジェクトルートに置いた `.nvim.lua` + `.nvim/` から、Neovim設定・LSP/formatter上書き・スニペットをそのプロジェクト限定で適用できるようにする。

**Architecture:** Neovim標準の `exrc` 機構（信頼ハッシュベース）で `<CWD>/.nvim.lua` をブートストラップとして読み込み、`.nvim/init.lua` 以下に実コードを置く。スニペットは blink.cmp の snippets ソースの `search_paths` に CWD の `.nvim/snippets` を動的追加することで、friendly-snippets 互換のVSCode形式JSONを読ませる。

**Tech Stack:** Neovim 0.11+ (`vim.o.exrc`, `vim.lsp.config`, `vim.snippet`), lazy.nvim, blink.cmp, friendly-snippets

**Spec:** `docs/superpowers/specs/2026-05-11-project-local-nvim-config-design.md`

---

## ファイル構造

dotfilesリポジトリで変更/作成するファイル:

| パス | 種別 | 責務 |
|------|------|------|
| `nvim/lua/kseki2/core/options.lua` | Modify | `vim.o.exrc = true` を追加 |
| `nvim/lua/kseki2/plugins/blink-cmp.lua` | Modify | snippets ソースの `search_paths` を関数化し CWD の `.nvim/snippets` を条件付き追加 |
| `nvim/README.md` | Create | このNeovim設定の概要、およびプロジェクトローカル設定の使い方を記載 |

プロジェクト側に置くファイル（READMEに使い方として書くだけで、dotfiles内には作らない）:
- `<project>/.nvim.lua` — `dofile('.nvim/init.lua')` 相当の数行
- `<project>/.nvim/init.lua` — プロジェクト固有のLua
- `<project>/.nvim/snippets/package.json` — friendly-snippets互換マニフェスト
- `<project>/.nvim/snippets/<lang>.json` — VSCodeスニペット

注意: Neovim設定リポジトリのため自動テストは無い。各タスクの検証は手動で行う。

---

### Task 1: exrc を有効化する

**Files:**
- Modify: `nvim/lua/kseki2/core/options.lua`

- [ ] **Step 1: options.lua に `vim.o.exrc = true` を追加**

`nvim/lua/kseki2/core/options.lua` の `opt.autoread = true` の直後（既存のグローバル系オプションの並びの末尾）に以下を追加:

```lua
-- Project-local config: enable exrc so <CWD>/.nvim.lua is auto-loaded
-- (Neovim shows a trust prompt on first encounter; use :trust to allow)
vim.o.exrc = true
```

ファイル末尾の `opt.iskeyword:append("-")` の下ではなく、冒頭付近の `opt.autoread`、`opt.encoding` の並びの直後に置く（グローバル挙動系をまとめるため）。

- [ ] **Step 2: 手動検証 — exrcがONになっていること**

検証手順:
1. `nvim` を起動
2. `:lua print(vim.o.exrc)` を実行
3. 期待: `true` が表示される

- [ ] **Step 3: 手動検証 — exrc の信頼フロー**

検証手順:
1. 一時ディレクトリで `mkdir -p /tmp/exrc-test && cd /tmp/exrc-test`
2. `echo 'vim.notify("project-local loaded")' > .nvim.lua`
3. `nvim` を起動
4. 期待: 起動時に "Trust this file?" 系のプロンプトが出る
5. `:trust` を実行 → `:q` で抜ける
6. 再度 `nvim` を起動
7. 期待: プロンプトは出ず、`project-local loaded` の通知が表示される
8. 確認後 `/tmp/exrc-test` を削除

- [ ] **Step 4: コミット**

```bash
git add nvim/lua/kseki2/core/options.lua
git commit -m "feat(nvim): exrcを有効化しプロジェクトローカル設定を読み込めるようにする"
```

---

### Task 2: blink.cmp の snippets ソースに CWD の `.nvim/snippets` を追加

**Files:**
- Modify: `nvim/lua/kseki2/plugins/blink-cmp.lua`

現状の `nvim/lua/kseki2/plugins/blink-cmp.lua` は、`sources.providers` に `copilot` だけを定義し、`snippets` ソースは blink.cmp のデフォルト設定（`vim.fn.stdpath('config') .. '/snippets'` のみを検索）が使われている。これをCWDの `.nvim/snippets` も検索するように拡張する。

- [ ] **Step 1: search_paths を返す小さなヘルパー関数を追加**

ファイル冒頭の `return {` の直前に以下を追加:

```lua
local function snippet_search_paths()
  local paths = { vim.fn.stdpath("config") .. "/snippets" }
  local project_snippets = vim.fn.getcwd() .. "/.nvim/snippets"
  if vim.uv.fs_stat(project_snippets) then
    table.insert(paths, 1, project_snippets)
  end
  return paths
end
```

ポイント:
- デフォルトの `~/.config/nvim/snippets` も維持する（blink.cmpの仕様で `search_paths` を指定するとデフォルトを上書きするため、自前で含める必要がある）
- CWDのスニペットを先頭に挿入することで、同名トリガがある場合プロジェクト側が優先される
- `vim.uv.fs_stat` は Neovim 0.10+ で利用可能

- [ ] **Step 2: snippets プロバイダ設定を providers に追加**

現状の `sources.providers` セクション:

```lua
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
```

これを以下のように変更（snippets プロバイダの opts を追加）:

```lua
sources = {
  default = { "copilot", "lsp", "path", "snippets", "buffer" },
  providers = {
    copilot = {
      name = "copilot",
      module = "blink-copilot",
      score_offset = 100,
      async = true,
    },
    snippets = {
      opts = {
        search_paths = snippet_search_paths(),
      },
    },
  },
},
```

注意: `snippet_search_paths()` は lazy.nvim の `opts` 評価時に1度だけ呼ばれる。これは `nvim` 起動時のCWDで決まる前提（仕様）。後から `:cd` しても切り替わらないが、設計の「再起動前提」と合致している。

- [ ] **Step 3: 手動検証 — デフォルトスニペットが従来通り動くこと**

検証手順:
1. プロジェクト外の場所（例: `cd ~`）で `nvim test.lua` を起動
2. `local fn` などと打ち補完候補を確認
3. 期待: friendly-snippets のスニペットが従来通り出てくる（リグレッションなし）

- [ ] **Step 4: 手動検証 — プロジェクトローカルスニペットが読み込まれること**

検証手順:
1. 一時プロジェクトを作る:
   ```sh
   mkdir -p /tmp/snip-test/.nvim/snippets
   cd /tmp/snip-test
   cat > .nvim/snippets/package.json <<'EOF'
   {
     "name": "test-snippets",
     "contributes": {
       "snippets": [
         { "language": "lua", "path": "./lua.json" }
       ]
     }
   }
   EOF
   cat > .nvim/snippets/lua.json <<'EOF'
   {
     "Project Hello": {
       "prefix": "phello",
       "body": ["-- hello from project: ${1:name}"],
       "description": "Project-local test snippet"
     }
   }
   EOF
   ```
2. `nvim test.lua` を起動
3. `phello` と打って補完候補を確認
4. 期待: "Project Hello" がスニペット候補に出る
5. 確認後 `/tmp/snip-test` を削除

- [ ] **Step 5: コミット**

```bash
git add nvim/lua/kseki2/plugins/blink-cmp.lua
git commit -m "feat(nvim): blink.cmpでプロジェクトローカルスニペットを読み込めるようにする"
```

---

### Task 3: `nvim/README.md` を作成しプロジェクトローカル設定の使い方を記載

**Files:**
- Create: `nvim/README.md`

- [ ] **Step 1: README.md を以下の内容で作成**

```markdown
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

\`\`\`
<project-root>/
├── .nvim.lua                       # exrcブートストラップ
└── .nvim/
    ├── init.lua                    # プロジェクト固有のLua設定
    └── snippets/
        ├── package.json            # friendly-snippets互換マニフェスト
        └── <filetype>.json         # VSCode形式スニペット
\`\`\`

### `.nvim.lua`（ブートストラップ）

Neovim 標準の `exrc` 機構で自動読み込みされる。中身は `.nvim/init.lua` を呼ぶだけにしておく:

\`\`\`lua
local entry = vim.fn.getcwd() .. "/.nvim/init.lua"
if vim.uv.fs_stat(entry) then
  local ok, err = pcall(dofile, entry)
  if not ok then
    vim.notify("project-local config error: " .. tostring(err), vim.log.levels.ERROR)
  end
end
\`\`\`

### `.nvim/init.lua`（プロジェクト固有設定）

通常の Lua として何でも書ける。例:

\`\`\`lua
-- インデントをこのプロジェクトだけ4スペースに
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- LSP サーバ設定の上書き
vim.lsp.config("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})

-- conform.nvim の formatter 上書き
require("conform").formatters_by_ft.lua = { "stylua" }
\`\`\`

### スニペット

friendly-snippets と同じ VSCode 形式。`.nvim/snippets/package.json` で contribute 宣言する:

\`\`\`jsonc
{
  "name": "project-snippets",
  "contributes": {
    "snippets": [
      { "language": "lua", "path": "./lua.json" },
      { "language": ["typescript", "typescriptreact"], "path": "./ts.json" }
    ]
  }
}
\`\`\`

各 `<lang>.json` の中身は VSCode 規格:

\`\`\`json
{
  "Console Log": {
    "prefix": "clog",
    "body": ["console.log(\"${1:msg}\", ${2:value});"],
    "description": "console.log with placeholder"
  }
}
\`\`\`

プロジェクト側のスニペットは検索パスの先頭に挿入されるため、friendly-snippets と同名トリガがある場合はプロジェクト側が優先される。

### 信頼モデル

`.nvim.lua` を含むディレクトリで初めて `nvim` を起動すると、Neovim から信頼確認のプロンプトが出る。許可する場合:

\`\`\`
:trust
\`\`\`

信頼ハッシュは `~/.local/state/nvim/trust` に保存される。`.nvim.lua` 自体を編集すると次回起動時にもう一度プロンプトが出る（`.nvim/init.lua` 以下の変更では出ない）。

### 制限事項

- プロジェクトルートの自動検出はしない。CWD がプロジェクトルートである前提。`cd <project>` してから `nvim` を起動する
- `:cd` でディレクトリを変えてもスニペットの検索パスは切り替わらない（再起動が必要）
- スニペットは VSCode 形式 JSON のみサポート（blink.cmp の仕様）
```

注: 上記の Markdown 内 `\`\`\`` は実際のファイルでは ` ``` ` （バックスラッシュなし）で書くこと。Writeツール上のエスケープに惑わされないよう、最終ファイルではコードフェンスが3バックティックになっていること。

- [ ] **Step 2: README.md の中身を目視確認**

```bash
cat nvim/README.md
```
期待: コードブロックがすべて ``` で囲まれており、バックスラッシュエスケープが残っていないこと。残っていたら直すこと。

- [ ] **Step 3: コミット**

```bash
git add nvim/README.md
git commit -m "docs(nvim): プロジェクトローカル設定の使い方をREADMEに追加"
```

---

### Task 4: 一連の動作を統合検証

**Files:**
- なし（手動検証のみ）

- [ ] **Step 1: 統合シナリオの検証**

検証手順:
1. 一時プロジェクトを作る:
   ```sh
   mkdir -p /tmp/integration-test/.nvim/snippets
   cd /tmp/integration-test

   cat > .nvim.lua <<'EOF'
   local entry = vim.fn.getcwd() .. "/.nvim/init.lua"
   if vim.uv.fs_stat(entry) then
     local ok, err = pcall(dofile, entry)
     if not ok then
       vim.notify("project-local config error: " .. tostring(err), vim.log.levels.ERROR)
     end
   end
   EOF

   cat > .nvim/init.lua <<'EOF'
   vim.opt.shiftwidth = 8
   vim.notify("project config applied")
   EOF

   cat > .nvim/snippets/package.json <<'EOF'
   {
     "name": "integration-test",
     "contributes": {
       "snippets": [{ "language": "lua", "path": "./lua.json" }]
     }
   }
   EOF

   cat > .nvim/snippets/lua.json <<'EOF'
   {
     "Integration Marker": {
       "prefix": "imark",
       "body": ["-- integration: ${1:tag}"],
       "description": "Integration test snippet"
     }
   }
   EOF
   ```
2. `nvim test.lua` を起動
3. 初回: 信頼プロンプトが出る → `:trust`、`:q`
4. 再度 `nvim test.lua` を起動
5. 検証:
   - 起動時に `project config applied` の通知が出る
   - `:lua print(vim.o.shiftwidth)` が `8` を返す
   - `imark` と打って "Integration Marker" がスニペット候補に出る
6. 後片付け: `/tmp/integration-test` を削除

- [ ] **Step 2: リグレッション検証**

検証手順:
1. dotfiles リポジトリの中（`.nvim.lua` がない場所）で `nvim` を起動
2. 検証:
   - 信頼プロンプトは出ない
   - 起動時にエラーや警告メッセージが出ない（`:messages` で確認）
   - 通常の友達スニペットが補完候補に出る（適当な lua ファイルを開いて確認）

- [ ] **Step 3: PR 用ブランチを作るかブランチをマージ**

現在のブランチが `feat/enable-wrap` であれば、別ブランチに切り替えてからプッシュ/PR 作成すること（必要に応じて）。

```bash
git status
git log --oneline -5
```

確認後、ユーザーに次のアクション（PR 作成 or マージ）を確認する。

---

## Self-Review チェック結果

- **Spec coverage**: 設計の全セクション（ファイル配置、データフロー、コンポーネント、エラー処理、信頼モデル、テスト方針）に対応するタスクあり。README作成も Task 3 でカバー
- **Placeholder scan**: 「TBD」「TODO」「実装時に追加」等は本プランには無し。各 step に実コードと検証手順を含む
- **Type/API consistency**: `snippet_search_paths()` 関数名、blink.cmp の `sources.providers.snippets.opts.search_paths` キー名、`vim.o.exrc` のキー名、すべて Task 1–4 を通じて整合
