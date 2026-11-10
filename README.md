# skills

Claude Code と Cursor で使う Agent Skills。[yug1224/dotfiles](https://github.com/yug1224/dotfiles) の `make mise` が、このリポジトリを `~/Workspaces/yug1224/skills` に clone し、`gh skill install --from-local` で `~/.claude/skills/` にコピーする（Cursor も同じ場所を読む）。

## インストール

```bash
gh skill install ~/Workspaces/yug1224/skills --from-local --all --agent claude-code --scope user --force
```

dotfiles からは `mise -C ~/.dotfiles run skills:update` で同じことをする。clone の作業ツリーがそのまま入るので、別のブランチや commit 前の変更も入る。GitHub の最新を入れるときは、先に clone を `git pull` する（`make mise` も pull はしない）。

`--from-local` で入れたものは `gh skill update` の対象にならない。更新は上のコマンドで入れ直す。`gh skill` はファイルをコピーするので、`~/.claude/skills/` を直接直しても次に入れ直すと上書きされる。直すときはこのリポジトリを直す。

`--force` でも、元から消したファイルはインストール先に残る。Skill のファイルを消したり名前を変えたりしたときは、インストール先の該当ディレクトリを消してから入れ直す。

## 構成

```
skills/
├── <verb>-<object>/SKILL.md   # ワークフロー（条件付きで読む大きい素材だけ references/）
└── shared-rules/              # 複数の Skill が Read する規約の置き場（参照専用・自動では呼ばれない）
    └── references/{conventions,blog}/*.md
```

規約の Git 外の上書きは `~/.claude/skills/local-rules/references/<domain>/<name>.local.md` に置く想定で、存在するときだけ Read する。無くても動く。

## 出典・蒸留

外部ソースを蒸留したものの一覧。claude.ai の Skill（`japanese-tech-writing` / `cognitive-rhythm-writing`）に同じ原典のものがあっても、正本はここに置いたものとする。原典の更新は gist の履歴を見て手で取り込む（最終確認: 2026-10-26）。

| ファイル                                                  | 原典                                                                                                                                                                                     | ライセンス                                                                       |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `skills/shared-rules/references/blog/blog-review-rule.md` | [nwiizo gist](https://gist.github.com/nwiizo/10bca6bb6eb5a81c3095ce46aaed1954)（観点 1〜5）、[nwiizo gist](https://gist.github.com/nwiizo/c75043438866100452fd249e536341d4)（観点 6・7） | 原典に表記なし                                                                   |
| `skills/apply-japanese-tech-writing/SKILL.md`             | [k16shikano gist](https://gist.github.com/k16shikano/fd287c3133457c4fd8f5601d34aa817d)（LLM 空句・翻訳調・冗長・見出しの節を抜粋）                                                       | [Unlicense](https://gist.github.com/k16shikano/67625f2a7d96e3bbdfae8d571a936063) |
| `skills/apply-cognitive-rhythm-writing/SKILL.md`          | [k16shikano gist](https://gist.github.com/k16shikano/eb2929f13ed19c97188393d297be8432)                                                                                                   | [Unlicense](https://gist.github.com/k16shikano/67625f2a7d96e3bbdfae8d571a936063) |
