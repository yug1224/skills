# コミットメッセージ規約

Conventional Commits を基本に、次の独自仕様を足す。

## フォーマット

```
<type>(<scope>): <subject> [<ticket-id>]

<body>

<footer>
```

- 日本語で書く（技術用語は英語可）
- type は `feat` / `fix` / `refactor` / `perf` / `docs` / `style` / `test` / `chore` の 8 種
- ヘッダー全体で 72 文字以内（subject は 50 文字以内が目安）
- チケット ID が判明しているときだけ、subject 末尾に `[TICKET-ID]` を付ける
- GitHub PR / Issue は同一リポジトリ内でも `{org}/{repo}#{番号}` で参照する（ベアの `#123` は転記先でリンクが切れる）

## 提案手順

- **Must have**: `type(scope): subject` + 変更点の箇条書き
- **Nice to have**: 上記 + 変更理由 + footer（該当時）

## 出力フォーマット

見出しは地の文で出し、コードブロックにはコミットメッセージだけを入れる（全体をコードブロックで囲まない）。type / scope の選択理由を短く添える。

### Must have

```
type(scope): subject
- 変更点1
```

### Nice to have

```
type(scope): subject
変更理由。
- 変更点1
Closes org/repo#123
```
