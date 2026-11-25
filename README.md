# skills

Claude Code と Cursor で使う Agent Skills。[yug1224/dotfiles](https://github.com/yug1224/dotfiles) の `make mise` が、このリポジトリを `~/Workspaces/yug1224/skills` に clone し（mise の `[bootstrap.repos]`）、`gh skill install --from-local` で `~/.claude/skills/` を作り直す（Cursor も同じ場所を読む）。

## インストール

dotfiles を使うときは `mise -C ~/.dotfiles run skills:update` で入れ直す。このタスクは別の場所に全部入れてから `~/.claude/skills/` と入れ替えるので、Skill の中のファイルや Skill そのものを消したり名前を変えたりしても、そのまま反映される。clone の作業ツリーがそのまま入るので、別のブランチや commit 前の変更も入る。GitHub の最新を入れるときは、先に clone を `git pull` する（`make mise` も pull はしない）。

dotfiles を使わずに入れるときは次のコマンドを使う。

```bash
gh skill install ~/Workspaces/yug1224/skills --from-local --all --agent claude-code --scope user --force
```

`--from-local` で入れたものは `gh skill update` の対象にならない。更新は入れ直す。`gh skill` はファイルをコピーするので、`~/.claude/skills/` を直接直しても次に入れ直すと上書きされる。直すときはこのリポジトリを直す。このコマンドで入れたときは、`--force` でも元から消したファイルや Skill がインストール先に残るので、手で消す。

## 構成

```
skills/
├── <verb>-<object>/SKILL.md   # ワークフロー（条件付きで読む大きい素材だけ references/）
└── shared-rules/              # 複数の Skill が Read する規約の置き場（参照専用・自動では呼ばれない）
    └── references/{conventions,blog}/*.md
scripts/check-upstream.sh      # 出典表の gist が更新されていないか確かめる
```

規約の Git 外の上書きは `~/.claude/skills/local-rules/references/<domain>/<name>.local.md` に置く想定で、存在するときだけ Read する。無くても動く。命名・配置・上書きの決まりと push 前の漏洩チェックは [CONVENTIONS.md](CONVENTIONS.md)。

## 開発

```bash
pnpm install
lefthook install
```

| コマンド                  | 内容                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------- |
| `pnpm run fmt:fix`        | oxfmt で整形する（pre-commit でも staged ファイルに走る）                                   |
| `pnpm run skills:check`   | `gh skill publish --dry-run` で、name とディレクトリ名の一致や必須の frontmatter を検証する |
| `pnpm run upstream:check` | 下の出典表の gist が更新されていないか確かめる                                              |

pre-commit は oxfmt と secretlint を回す。CI は `fmt:check` と `skills:check` を回す。

## ライセンス

[MIT](LICENSE)。ただし次の「出典・蒸留」の表にあるファイルは原典のライセンスに従い、MIT の対象外とする。

## 出典・蒸留

外部ソースを蒸留したものの一覧。claude.ai の Skill（`japanese-tech-writing` / `cognitive-rhythm-writing`）に同じ原典のものがあっても、正本はここに置いたものとする。リンクは取り込んだ時点の revision を指し、同じ URL を各ファイルにも出典として書く（SKILL.md は frontmatter の `license` と `metadata.source`）。`pnpm run upstream:check` で gist の最新 revision と比べ、差分があれば revisions ページを見て手で取り込み、リンクの revision を書き換える（gist の `updated_at` はスターやコメントでも変わるので、更新の判定には使わない）。GitHub リポジトリの原典は `upstream:check` の対象外なので、更新は手で確かめる。

| ファイル                                                        | 原典                                                                                                                                                                                                                                                                       | ライセンス                                                                                            |
| --------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `skills/shared-rules/references/blog/blog-review-rule.md`       | [nwiizo gist](https://gist.github.com/nwiizo/10bca6bb6eb5a81c3095ce46aaed1954/506438d7312892a9e37a2b5d82f8c9a5cfc61766)（観点 1〜5）、[nwiizo gist](https://gist.github.com/nwiizo/c75043438866100452fd249e536341d4/7287cb3bd9590a07f4a084520818b029cf5c4f16)（観点 6・7） | 原典に表記なし                                                                                        |
| `skills/apply-japanese-tech-writing/SKILL.md`                   | [k16shikano gist](https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d/8f2d57610a73efc97d743c9b0b0ecb1002e09fa4)（LLM 空句・翻訳調・冗長・見出しの節を抜粋）                                                                                                | [Unlicense](https://gist.github.com/k16shikano/67625f2a7d96e3bbdfae8d571a936063)                      |
| `skills/apply-cognitive-rhythm-writing/SKILL.md`                | [k16shikano gist](https://gist.github.com/k16shikano/eb2929f13ed19c97188393d297be8432/a3b1e26beced71d582e13314fb6f5b179b023c76)                                                                                                                                            | [Unlicense](https://gist.github.com/k16shikano/67625f2a7d96e3bbdfae8d571a936063)                      |
| `skills/analyze-issue/SKILL.md`（手順 2 と手順 5 の試作の指示） | [pstack](https://github.com/cursor/plugins/tree/f16683119d15a72a44579a8ab58bde5d903ffcb7/pstack/skills)（`reframe` の曖昧さの扱い、`sharpen` の熟練者の視点と実験で決める指示）                                                                                            | [MIT](https://github.com/cursor/plugins/blob/f16683119d15a72a44579a8ab58bde5d903ffcb7/pstack/LICENSE) |
