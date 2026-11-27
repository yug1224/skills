# pstack 呼び出しルール

[pstack](https://github.com/cursor/plugins/tree/main/pstack) の Skill を、別の Skill の手順から使う方法。pstack の Skill は `disable-model-invocation: true` なので Skill ツールでは呼べない。本文を Read して従う。

## 場所

- `jq -r '.plugins["pstack@cursor-plugins"][0].installPath' ~/.claude/plugins/installed_plugins.json` の出力を `<pstack>` とする
- 見つからなければその手順を飛ばし、終了報告に「pstack なし: <手順> を省略」と書く

## 使い方

- Claude Code で動かすときだけ、最初の 1 回 `<pstack>/docs/harness/claude-code.md` を Read し、Cursor の名前を Claude Code の名前に読み替える
- `<pstack>/skills/<name>/SKILL.md` を Read して従う。その中で別の pstack Skill を呼ぶときも同じ
- 比較先は `code-review-rule.md` の「対象と比較先」で決めたものを渡す（pstack の既定は `main`）
- 出力の言語・テンプレート・文章規範は呼び出し元の Skill に従う。pstack の `unslop` / `technical-writing` は使わない
- コミット・push・PR の作成はしない。呼び出し元の Skill かユーザーの指示に従う
- 検証用の一時ファイルは `~/.claude/skills/shared-rules/references/conventions/code-review-rule.md` の「一時ファイル」に従う
