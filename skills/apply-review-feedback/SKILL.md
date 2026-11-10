---
name: apply-review-feedback
description: PR / diff の指摘とセルフレビューを判定し、妥当なものだけコードで直す
disable-model-invocation: true
---

PR コメント・レビュー Bot の指摘・セルフレビューを 対応 / WONTFIX / 待ち に分類し、妥当なものだけコードで直す。PR が無いときは渡された差分へのセルフレビューとして動く。

**Input**: GitHub PR URL / diff の貼り付け / `ローカル差分` のいずれか（必須）。

## Steps

1. `~/.claude/skills/shared-rules/references/conventions/` の `review-feedback-rule.md`・`code-review-rule.md`・`review-report-rule.md` を Read する。`~/.claude/skills/local-rules/references/conventions/` の `review-feedback-rule.local.md` と `code-review-rule.local.md` は存在するものだけ Read する（矛盾時は `.local.md` を優先）
2. 「前提」「判定」「ループ」に従い、「終了報告」を出力する
