---
name: suggest-development-log
description: チケットと PR から開発ログを MECE 構造で生成する。タスク対応の開発ログ・作業記録をまとめたいときに使う
license: MIT
---

チケットと GitHub PR の情報から、固定テンプレートに沿った開発ログを作る。

**Input**: チケット URL または ID（必須）、GitHub PR URL（任意・複数可）。

## Steps

1. 次を Read する
   - `~/.claude/skills/apply-japanese-tech-writing/SKILL.md`
   - `~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md`（存在すれば。チケット取得の手順）
2. `~/.claude/skills/suggest-development-log/references/development-log-template.md` を Read し、そのテンプレートと記載量の目安で書く（WIP / Draft PR は「進行中」と明記）
3. `~/.claude/skills/yomiyasu/SKILL.md` を Read して推敲する（存在するときだけ）。推敲後も Step 2 のテンプレートと記載量を優先する
4. 推敲した案を提示する
