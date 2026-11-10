#!/usr/bin/env bash
# README の出典表と各 Skill の出典表記にある gist の revision を、gist の最新 revision と比べる。
# 差分があれば取り込み元の revisions ページを出して exit 1。
set -euo pipefail
cd "$(dirname "$0")/.."

stale=0
# 対象は revision 付きのリンク（https://gist.github.com/<user>/<id>/<sha>）だけ
while read -r user id rev; do
  latest="$(gh api "gists/$id/commits" --jq '.[0].version')"
  if [[ "$latest" != "$rev" ]]; then
    echo "stale: $user/$id ($rev -> $latest) https://gist.github.com/$user/$id/revisions"
    stale=1
  fi
done < <(grep -rhoE 'https://gist\.github\.com/[^/]+/[0-9a-f]{32}/[0-9a-f]{40}' README.md skills \
  | sort -u | awk -F/ '{print $4, $5, $6}')

exit "$stale"
