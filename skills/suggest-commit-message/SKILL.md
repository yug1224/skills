---
name: suggest-commit-message
description: ステージング済みの変更からコミットメッセージを 1 案提案する。コミットメッセージを考えてほしいと頼まれたときに使う。コミットはしない
license: MIT
---

ステージング済みの変更から、コミットメッセージを 1 案提案する。

**Input**: チケット ID または URL（任意）。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/commit-message-rule.md` を Read する
2. チケット引数があるときだけ取得する（`~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md` が存在すれば Read してその手順に従う）
3. `commit-message-rule` の「提案手順」「出力フォーマット」に従って案を作る
4. `~/.claude/skills/yomiyasu/SKILL.md` を Read して推敲する（存在するときだけ）。推敲後も Step 3 の書式を優先する
5. 推敲した案を提示する
