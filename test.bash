#!/bin/bash
# SPDX-FileCopyrightText: 2026 kageyama yakumo
# SPDX-License-Identifier: BSD-3-Clause

ng () { echo ${1}行目のテスト失敗; res=1; }
res=0
cmd=$(pwd)/gacp

### 準備 ###
tmp=$(mktemp -d)
git init -q --bare $tmp/remote.git
git clone -q $tmp/remote.git $tmp/work 2>/dev/null
cd $tmp/work
git config user.name test
git config user.email test@example.com
git commit -q --allow-empty -m init
git push -q -u origin HEAD

### NORMAL INPUT ###
echo hello > a.txt
out=$(echo a.txt | $cmd "first")
[ "$?" = 0 ] || ng "$LINENO"
echo "$out" | grep -q "first" || ng "$LINENO"
[ "$(git -C $tmp/remote.git log -1 --format=%s)" = first ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo a.txt | $cmd)
[ "$?" = 1 ] || ng "$LINENO"
[ "$out" = "" ] || ng "$LINENO"
out=$(echo nofile | $cmd "x")
[ "$?" = 1 ] || ng "$LINENO"
out=$(echo -n | $cmd "x")
[ "$?" = 1 ] || ng "$LINENO"
out=$(echo a.txt | $cmd "nochange")
[ "$?" = 1 ] || ng "$LINENO"

rm -rf $tmp
[ "$res" = 0 ] && echo OK
exit $res
