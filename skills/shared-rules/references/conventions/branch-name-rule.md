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

- 1 案だけ出す。チケット ID があれば `type/ticket-id-name`、無ければ `type/name`

## 出力フォーマット

コードブロックにはブランチ名 1 行だけを入れる。type の選択理由を短く添える。

```
type/PROJ-XXXX-branch-name
```
