---
name: suggest-commit-message
description: ステージング済みの変更からコミットメッセージを Must have / Nice to have で提案する。コミットメッセージを考えてほしいと頼まれたときに使う。コミットはしない
---

ステージング済みの変更から、コミットメッセージを Must have / Nice to have の 2 パターンで提案する。

**Input**: チケット ID または URL（任意）。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/commit-message-rule.md` を Read する
2. チケット引数があるときだけ取得する（`~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md` が存在すれば Read してその手順に従う）
3. `commit-message-rule` の「提案手順」「出力フォーマット」に従って提示する
