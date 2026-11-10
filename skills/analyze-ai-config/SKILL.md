---
name: analyze-ai-config
description: AI 資産（skills / rules / commands / agents）を global・shared・project 横断で棚卸しする（読み取り専用）。AI 設定の重複・衝突・配置を確かめたいときに使う
---

skills / rules / commands / agents を横断し、global・shared・project の AI 設定を棚卸しする。調査のみで、ファイルは作成・変更・削除しない。

**Input**: 引数（任意）。なし / `all` で全種別、`skills` / `rules` / `commands` / `agents` で当該種別のみ、`local` で `.local.*` と `skills/local-*/` に絞る。それ以外は id / path の部分一致で絞り込む。

`~/.claude/skills/local-rules/references/overlays/analyze-ai-config.md` が存在すれば Read する（矛盾時はこちらを優先）。

## 探索範囲

| scope   | 根                                                                                         |
| ------- | ------------------------------------------------------------------------------------------ |
| global  | `~/.claude/`, `~/.cursor/`, `~/.agents/`                                                   |
| shared  | `~/.config/shared/ai/`（dotfiles の `make mise` 展開先。hooks・docs・`rules/meta`）        |
| project | `<cwd>/.claude/`, `<cwd>/.cursor/`, `<cwd>/.agents/`, `<cwd>/AGENTS.md`, `<cwd>/CLAUDE.md` |

各根の `skills/` `rules/` `commands/` `agents/` を Glob する。`.local.*` は gitignore されていても対象にし、`_archived/` は除外する。存在しないパスは失敗扱いにしない。

この環境だけの前提:

- `~/.claude/skills/` の Skill は `gh skill install` が入れたコピー。frontmatter の `metadata` に入手元がある。名前が `local-` で始まるもの（`local-*` と `local-rules`）は local、それ以外は shared として数える。`metadata` が無いものは手で置いたものとして所見に挙げる
- `~/.claude/skills/` を直接直すと、次に入れ直したとき（`skills:update`）に上書きされる。直すなら入手元のリポジトリを直す
- Cursor は `~/.claude/skills` と `<cwd>/.claude/skills` も読む。`~/.cursor/skills` / `.cursor/skills` / `.agents/skills` と同名の Skill があれば、Cursor で二重表示になるので衝突として挙げる
- `~/.cursor/skills-cursor/` は Cursor 同梱。列挙だけする

## 出力フォーマット

1. **件数サマリー**: 種別ごとの件数（global / shared / project / local）
2. **種別テーブル**: `path | id | description/alwaysApply/globs/model | scope | local | collision`。id は Skill なら親ディレクトリ名、それ以外は `name:` または `.local` と拡張子を除いた basename
3. **所見**（任意）: 同一 id の複数スコープ、Skill と command の同名、孤立した shared など、直す価値のあるものだけ
