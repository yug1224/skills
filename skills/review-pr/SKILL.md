---
name: review-pr
description: GitHub PR かローカル差分をレビューし、判定と P0/P1/P2 の指摘（そのまま貼れるインラインコメント案）を固定テンプレートで返す。PR のレビューレポートや、PR 作成前のセルフレビューがほしいときに使う。コメント投稿・コード修正はしない。形式を問わないバグ探しや PR へのコメント投稿は組み込みの /code-review を使う
---

差分を既存実装と対象リポジトリのルールに照らしてレビューし、`review-report-rule` の出力テンプレートで報告する。

**Input**: GitHub PR URL・PR 番号・`ローカル差分` のいずれか（任意）。無ければ現在のブランチの PR を `gh pr view` で探し、それも無ければローカル差分を対象にする。差分も空なら入力を求めて終了する。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/code-review-rule.md` と `review-report-rule.md` を Read する。`~/.claude/skills/local-rules/references/conventions/code-review-rule.local.md` が存在すれば Read する（矛盾時は `.local.md` を優先）
2. 対象を取る
   - PR: 読み取りの `gh`（`gh pr view` / `gh pr diff` / `gh pr checks`）で、タイトル・本文・ベースブランチ・差分・CI 状態・既存レビューコメントを取る。`gh` が使えなければ GitHub MCP で代替する
   - ローカル差分: `code-review-rule` の「対象と比較先」に従う
3. `code-review-rule` の「対象と比較先」で読むものを読み、「重要度」と「指摘の絞り方」に従って指摘の下書きを出す
4. `review-report-rule` の「反証」を通す
5. 出力テンプレートで提示する。判定のラベルは ✅ Approve / ⚠️ Comment / ❌ Request Changes。「対象 / スコープ」には PR かローカル差分か、比較先、変更ファイル数、CI 状態（PR のとき）を書く
