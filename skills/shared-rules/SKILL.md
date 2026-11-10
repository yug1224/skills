---
name: shared-rules
description: 他の Skill とカーネルが Read する公開規約の置き場。直接は使わない
disable-model-invocation: true
---

規約は相互に参照するので、ディレクトリ構成を保ったまま `references/` にまとめる。Read するパスは `~/.claude/skills/shared-rules/references/<domain>/<name>.md`。

| ファイル                                         | 内容                     |
| ------------------------------------------------ | ------------------------ |
| `references/conventions/branch-name-rule.md`     | ブランチ名               |
| `references/conventions/commit-message-rule.md`  | コミットメッセージ       |
| `references/conventions/code-review-rule.md`     | レビューの重要度・比較先 |
| `references/conventions/review-report-rule.md`   | レビューの反証と出力の型 |
| `references/conventions/review-feedback-rule.md` | 指摘対応                 |
| `references/blog/blog-review-rule.md`            | ブログ記事の評価基準     |

各規約の Git 外の上書きは `~/.claude/skills/local-rules/references/<domain>/<name>.local.md` に置く（存在するときだけ Read し、矛盾時はそちらを優先）。
