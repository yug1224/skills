# Skill と規約の命名・配置

このリポジトリ（公開）と、Git 外の private リポジトリに置く Skill・規約の決まり。Skill を足す・直すときに読む。インストールの仕組みは [README](./README.md)「インストール」。

## 命名

| 種別           | パターン                             | 配置                                                    |
| -------------- | ------------------------------------ | ------------------------------------------------------- |
| Skill          | `<verb>-<object>/SKILL.md`           | `skills/`（条件付きで読む大きい素材だけ `references/`） |
| ルール         | `<topic>-rule.md`                    | `skills/shared-rules/references/<domain>/`              |
| ローカル Skill | `local-<verb>-<object>/SKILL.md`     | private リポジトリの `skills/`                          |
| ローカル上書き | `<basename>.local.md` / `<skill>.md` | `skills/local-rules/references/<domain>/` / `overlays/` |

ファイル名は kebab-case。Skill は `<verb>-<object>`（ローカル Skill は先頭に `local-`）で、動詞は `suggest` / `review` / `plan` / `analyze` / `apply` / `create` から選ぶ（勝手に増やさない。`create` は動画などの生成物をファイルに書き出す Skill に使う）。例外は規約の置き場だけの参照専用 Skill（`shared-rules` / `local-rules`）で、`disable-model-invocation: true` を付ける。業務リポジトリ側の Skill は名詞先頭にして名前空間を分ける（dotfiles の `packages/shared/ai/docs/project-skills.md`）。

Skill は frontmatter（`name` / `description`）を本文先頭に持つ。`name` はディレクトリ名と一致させ、`description` に「何をするか」と「いつ使うか」を書く（Cursor はこれで自動適用を判断する）。公開側の Skill は `license` も書く（自作は `MIT`、外部を蒸留したものは原典のライセンス）。private リポジトリの Skill には書かない。ルールに frontmatter は書かない。`gh skill` は `skills/*/SKILL.md` を探すので、private リポジトリでも Skill は `skills/` 直下に置く。

## Skill の自動発火

ワークフローはすべて `skills/` に置き、コマンド（`commands/`）は使わない。両ツールとも `/<name>` で呼べる。自動発火の有無は frontmatter の `disable-model-invocation` で切り替える。

| frontmatter                      | 向くもの                                                                                       | 例                                                   |
| -------------------------------- | ---------------------------------------------------------------------------------------------- | ---------------------------------------------------- |
| `disable-model-invocation` なし  | 自然文の依頼（「コミットメッセージ考えて」）でも発火させたい、読み取りと提案だけのワークフロー | `suggest-commit-message`, `plan-blog`, `review-blog` |
| `disable-model-invocation: true` | 明示したときだけ動かすもの。自動発火させたくないワークフロー・再適用系・ローカル Skill         | `apply-review-feedback`                              |

- `disable-model-invocation: true` の Skill は Skill ツールから呼べない。ユーザーが別の Skill と続けて頼んだときに動かすなら、前の Skill の Step にその SKILL.md を Read させる（例: `review-pr` → `apply-review-feedback`）
- その Skill だけが使う手順・規約は SKILL.md 本文に書く（Skill 本文は呼ばれたときだけ読まれるので、分けても Read が 1 回増えるだけ）。`skills/<name>/references/` に分けるのは、条件付きでしか読まないものと、そのまま出力する長い固定文だけ。他の Skill・ルールからも参照されるルールは `shared-rules/references/` に置く（例: `commit-message-rule.md` は `suggest-pr-description` と `branch-name-rule.md` からも参照される）。規約同士が相互に参照するので、ディレクトリ構成を保ったまま 1 か所にまとめる
- ルールのパスは Skill の Step に書いて 1 回 Read させ、`@` でインライン展開しない（Claude Code は `@path` を起動時に展開するので二重に載る）
- Git 外のワークフローは private リポジトリの `skills/local-<name>/` に置く。Skill の `name` はディレクトリ名と一致させる必要があり、`.local` を含む名前を Skill 名にできないため、接頭辞 `local-` で区別する

## `.md` と `.local.md`

`.local.md` は差分・追記のみで、矛盾時は `.local.md` を優先する。`.md` の全文をコピーしない。`shared-rules/references/<domain>/<name>.md` を Read したら、`~/.claude/skills/local-rules/references/<domain>/<name>.local.md` が存在するときだけ Read する（`gh skill` はリポジトリごとに別ディレクトリへコピーするので、同じディレクトリには置けない）。

Skill への上書きは `local-rules/references/overlays/<skill>.md` に置き、その Skill の本文に Read の Step を書いたときだけ効く（Skill 本文はハーネスが注入するので自動では読まれない。現状は `analyze-ai-config` / `suggest-pr-description` / `suggest-x-post`）。単独のワークフローには使わない。

`.local.md` を公開側へ昇格させてよいのは、識別子フリーかつリポジトリ横断で再利用できるものだけ。

## 実装系とレビュー系を分ける

| フェーズ     | 主なファイル                                                            |
| ------------ | ----------------------------------------------------------------------- |
| 実装         | `coding-rule.local.md`                                                  |
| レビュー     | `skills/review-pr/SKILL.md`・`code-review-rule.md` + 任意の `.local.md` |
| レビュー対応 | `review-feedback-rule.md`・`code-review-rule.md` + 任意の `*.local.md`  |

実装とレビューの方針を 1 ファイルに混在させない。重要度・比較先・指摘の絞り方は `code-review-rule.md` に一本化し、指摘する側と直す側で同じ基準を使う。反証の手順と出力の型は `review-report-rule.md` にまとめ、`/review-blog` も同じ形式で返す。コードレビューは `/review-pr`（固定テンプレートのレポート。Cursor でも同じ名前で使う）で行い、Claude Code 組み込みの `/code-review` は形式を問わないときに使う。

## 書かないもの

モデルが指示なしでも守ることは書かない。例: 汎用のレビュー観点、Conventional Commits の type の説明、`gh` / `git` の基本的な使い方、出力前の自己点検、読んだルールの自己申告（ツール呼び出しは UI に表示される）、ハーネスや MCP がすでに注入している内容。ルールに残すのは、この環境だけの決まりと、モデルの既定の癖を矯正する指示だけにする。

## 漏洩チェック（公開側に push する前）

公開側はこのリポジトリと yug1224/dotfiles。

- [ ] tracked ファイルに会社名・製品名・非公開 URL・自社固有のワークスペースパスがない
- [ ] Skill の `description`・使用例・README に製品名が残っていない（プロバイダ固有は `.local` へ）
- [ ] チケット例に会社プレフィックスがない（`PROJ-1234` を使う）
- [ ] 公開 Skill が only-local ファイルを必須 Read していない（存在するときだけ Read する）
- [ ] rename 後の旧 basename 参照が残っていない
- [ ] 採用などドメイン固有の規約は private リポジトリの `local-rules/references/<domain>/*.local.md` だけに置き、公開側からは参照しない
- [ ] 公開側に private リポジトリの名前やパスがない

外部ソースを蒸留したときは [README](./README.md)「出典・蒸留」に追記する。
