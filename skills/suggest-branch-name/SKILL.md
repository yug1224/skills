---
name: suggest-branch-name
description: 変更内容やチケットからブランチ名を 1 案提案する。ブランチ名を決めたいときに使う。ブランチは作らない
license: MIT
---

変更内容（staged / unstaged の差分、会話、チケット）から、ブランチ名を 1 案提案する。

**Input**: チケット ID または URL（任意）。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/branch-name-rule.md` を Read する
2. チケット引数があるときだけ取得する（`~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md` が存在すれば Read してその手順に従う）
3. `branch-name-rule` の「提案手順」「出力フォーマット」に従って提示する。現在のブランチ名が規約に準拠していればその旨を添える
