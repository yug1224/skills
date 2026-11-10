# ブランチ名規約

## フォーマット

```
<type>/<description>
<type>/<ticket-id>-<description>
```

- 英字小文字のハイフン区切り。全体で 50 文字以内が目安
- type は [commit-message-rule](./commit-message-rule.md) の 8 種と同じ。同じ変更ではコミットと揃える
- チケット ID は任意で、description の先頭に付ける

## 提案手順

- **Must have**: `type/ticket-id-name`（規約準拠の標準的な命名）
- **Nice to have**: `type/ticket-id-descriptive-name`（より具体的）
- チケット ID が無いときは、どちらも ID なしで詳細度の違いとして出す

## 出力フォーマット

見出しは地の文で出し、コードブロックにはブランチ名 1 行だけを入れる。type の選択理由を短く添える。

### Must have

```
type/PROJ-XXXX-branch-name
```

### Nice to have

```
type/PROJ-XXXX-descriptive-branch-name
```
