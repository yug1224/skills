# コードレビュー基準

`review-pr`（指摘する側）と `apply-review-feedback`（直す側）が同じ基準で動くための定義。プロジェクト固有の観点と重要度の補正は `~/.claude/skills/local-rules/references/conventions/code-review-rule.local.md`（Git 外）に書く。

## 対象と比較先

- 比較先: PR は `gh pr view --json baseRefName` の `origin/<baseRefName>`、それ以外は `~/.claude/skills/local-rules/references/conventions/code-review-rule.local.md` の既定、無ければ `origin/HEAD`。`git fetch` はしない
- ローカル差分: `git diff HEAD`（staged と未 staged の両方）。空なら `git diff <比較先>...HEAD`
- 対象リポジトリの `.cursor/rules/` と `.claude/skills/` を ls し、変更範囲に関係するものだけ Read する
- チケット ID / URL が引数か PR 本文にあるときだけ背景を取る（`~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md` が存在すればその手順に従う）

## 重要度

| Priority | 意味                                           |
| -------- | ---------------------------------------------- |
| **P0**   | セキュリティ脆弱性・データ損失・クラッシュ     |
| **P1**   | バグ・誤動作・エッジケース漏れ・仕様不一致     |
| **P2**   | 保守性に実害がある設計・既存パターンからの逸脱 |

P0 / P1 は既存踏襲より正しさを優先し、P2 は既存実装を正とする。

## 指摘の絞り方

- 変更箇所の呼び出し元・呼び出し先と既存の類似実装を読んでから指摘する
- スタイル・好み・表記揺れだけの指摘は出さない
- 既存実装との乖離を根拠にするときは、比較先の `path:行` を添える
- 既存レビューコメントと同じ指摘は繰り返さず、未対応なら「既存コメント未対応」と書く

## ローカル検証

typecheck は重いので実行せず CI に任せる。lint・format・test は変更範囲だけを実行する。

- lint / format: リポジトリのルートに `lefthook.yml` があれば、変更ファイルに pre-commit を当てる。無ければ飛ばす。`--file` で `{staged_files}` を差し替えるので stage していない変更にも当たり、`--no-stage-fixed` で自動修正したファイルを `git add` しない

  ```bash
  { git diff --name-only --diff-filter=d <比較先>...HEAD; git diff --name-only --diff-filter=d HEAD; git ls-files --others --exclude-standard; } | sort -u | sed 's/^/--file=/' | xargs lefthook run pre-commit --no-stage-fixed --no-auto-install --no-tty
  ```

  ファイル一覧を変数に入れて `$(...)` で展開しない。zsh は単語分割しないので、最初の 1 ファイルしか渡らない。shortcut: 空白を含むパスは xargs で分割されて壊れる。該当するリポジトリが出たら `-z` と `xargs -0` に変える

- test: 変更ファイルに対応するテストだけを実行する。手順はリポジトリの ci-check 系 Skill か `~/.claude/skills/local-rules/references/conventions/coding-rule.local.md` に従う
- 実行しなかったもの（typecheck を含む）は「未検証」として報告する
