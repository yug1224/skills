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
