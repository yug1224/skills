---
name: suggest-review-reply
description: PR のインラインコメントへの返信文面を、そのまま貼れるコードブロックで提案する。レビューコメントに返信したいときに使う。投稿とコード修正はしない
license: MIT
---

PR のインラインコメントを読み、返信文面を提案する。コードの修正は `apply-review-feedback` が受け持つ。

**Input**: PR の URL かインラインコメントの URL（`...#discussion_r<id>`）。URL が無ければコメント本文の貼り付け。回答の方向性（「直した」「このままにする。理由は〜」など）は任意。

## Steps

1. 対象のコメントを読み取りの `gh` で取る
   - コメントの URL: `gh api repos/{owner}/{repo}/pulls/comments/{id}` で投稿者の `login`・本文・`path`・`line`・`diff_hunk` を取り、同じスレッドの返信も読む
   - PR の URL: `gh api graphql` で `pullRequest.reviewThreads`（`isResolved`・`path`・`line`・`comments { author { login } body }`）を取り、未解決で最後の発言が PR 作成者以外のスレッドだけを対象にする。0 件なら「返信待ちのインラインコメントはありません」と返して終了する
2. `diff_hunk` と手元のファイルで、指摘がすでに直っているかを確かめる。回答の方向性が渡されず、コードからも決められないときは「対応済み / 対応する / 対応しない」を聞いて止まる
3. 文面を作る
   - 1 行目: `@<login> ありがとうございます！`（`login` はスレッドの最後の発言者）
   - 2〜3 行目: 簡潔な回答。文末は「！」にし、「。」は使わない
4. `~/.claude/skills/yomiyasu/SKILL.md` を Read して推敲する（存在するときだけ）。推敲後も Step 3 の書式を優先する
5. 返信 1 件をコードブロック 1 つで出す。PR の URL のときは、スレッドごとに `path:line` と元コメントの要約 1 行を見出しにして並べる
