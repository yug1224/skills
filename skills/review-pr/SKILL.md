---
name: review-pr
description: GitHub PR かローカル差分をレビューし、判定と P0/P1/P2 の指摘（そのまま貼れるインラインコメント案）を固定テンプレートで返す。PR のレビューレポートや、PR 作成前のセルフレビューがほしいときに使う。コメント投稿・コード修正はしない。形式を問わないバグ探しや PR へのコメント投稿は組み込みの /code-review を使う
license: MIT
---

差分を既存実装と対象リポジトリのルールに照らしてレビューし、`review-report-rule` の出力テンプレートで報告する。

**Input**: GitHub PR URL・PR 番号・`ローカル差分` のいずれか（任意）。無ければ現在のブランチの PR を `gh pr view` で探し、それも無ければローカル差分を対象にする。差分も空なら入力を求めて終了する。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/code-review-rule.md` と `review-report-rule.md` を Read する。`~/.claude/skills/local-rules/references/conventions/code-review-rule.local.md` が存在すれば Read する（矛盾時は `.local.md` を優先）
2. 対象を取る
   - PR: 読み取りの `gh`（`gh pr view` / `gh pr diff` / `gh pr checks`）で、タイトル・本文・ベースブランチ・差分・CI 状態・既存レビューコメントを取る。`gh` が使えなければ GitHub MCP で代替する
   - ローカル差分: `code-review-rule` の「対象と比較先」に従う
3. `code-review-rule` の「対象と比較先」で読むものを読み、「重要度」と「指摘の絞り方」に従って指摘の下書きを出す
4. 差分がデータの書き込み・認証・認可・金額・並行処理に触れるとき、または入力に「敵対的」とあるときは、`~/.claude/skills/shared-rules/references/conventions/pstack-rule.md` に従って pstack の `interrogate` も走らせ、検証済みの指摘を下書きに加える（重要度は `code-review-rule` で付け直す）
5. `review-report-rule` の「反証」を通す。`code-review-rule` の「ローカル検証」の lefthook は回さない（oxlint の `--fix` で作業ツリーが変わるため）。実行して確かめるのは、反証の再現テストとコマンドだけにする
6. 出力テンプレートで提示する。判定のラベルは ✅ Approve / ⚠️ Comment / ❌ Request Changes。「対象 / スコープ」には PR かローカル差分か、比較先、変更ファイル数、CI 状態（PR のとき）を書く
7. ユーザーの依頼に `/apply-review-feedback` もあれば、報告のあとに `~/.claude/skills/apply-review-feedback/SKILL.md` を Read して、同じ対象で続ける（`disable-model-invocation` のため Skill ツールでは呼べない）
