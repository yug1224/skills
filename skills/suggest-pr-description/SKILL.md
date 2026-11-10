---
name: suggest-pr-description
description: プロジェクトの PR テンプレートに準拠した PR の Title と Description を生成・改善する。PR 本文を書きたい・直したいときに使う。PR の作成・更新はしない
---

利用可能な情報を分析し、**プロジェクトの PR テンプレートに準拠した** PR Title と Description を提案する。

**Input**: GitHub PR URL、チケット ID、チケット URL（すべて任意）。

## Steps

1. 次を Read する
   - `~/.claude/skills/apply-japanese-tech-writing/SKILL.md`
   - `~/.claude/skills/local-rules/references/overlays/suggest-pr-description.md`（存在すれば。矛盾時はこちらを優先）
   - チケット引数があるときのみ `~/.claude/skills/local-rules/references/conventions/ticket-retrieval-rule.local.md`（存在すれば）
2. 新規 PR は `origin/HEAD` が指す既定ブランチ（検出できなければ `develop` → `main`）との差分を見る
3. 下の「テンプレートの優先順位」でテンプレートを決め、「基本ルール」に従って作成し、「出力フォーマット」で提示する

## テンプレートの優先順位

1. **プロジェクトの PR テンプレート**: `.github/PULL_REQUEST_TEMPLATE.md`、`.github/PULL_REQUEST_TEMPLATE/` 配下、`.cursor/rules/` で定義されたテンプレート。セクション構成・見出し・チェックリストは変えない
2. **ビルトインテンプレート**: 上記が無いときだけ `~/.claude/skills/suggest-pr-description/references/pr-description-builtin-templates.md` を Read し、その変更ルールに従う

プロジェクトテンプレートに実装詳細を列挙するセクション（`### 主な実装内容`、`## 実装詳細`、`## Changes` 内のタスク列挙等）が無ければ、変更概要セクション（例: `## PR概要`）の直後に `### 主な実装内容` を足し、番号付きリストでタスク単位に書く。

## 基本ルール

- PR タイトルは `~/.claude/skills/shared-rules/references/conventions/commit-message-rule.md` のヘッダー 1 行と同じ形式（`type(scope): subject [TICKET-ID]`。Squash merge 時のコミットメッセージと揃える）。プロジェクトにタイトル慣習があればそちらを優先する
- 本文は日本語（技術用語は英語可）。テンプレートの全セクションを埋め、「目的」は 1 つだけ選ぶ

## 出力フォーマット

見出しは地の文で出し、コードブロックには Title / Description 本体だけを入れる（全体をコードブロックで囲まない）。本文中の ``` と衝突しないよう、フェンスはバッククォート 4 連（````）にする。

<!-- prettier-ignore-start -->
## PR Title

````
feat(scope): 変更概要 [TICKET-ID]
````

## PR Description

````markdown
（テンプレートに沿った PR Description 全文）
````
<!-- prettier-ignore-end -->

PR URL がある場合（既存 PR の改善）は、上記に加えて `## 改善ポイント` セクション（既存 Description からの変更点）を付ける。
