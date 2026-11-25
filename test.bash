#!/bin/bash
# SPDX-FileCopyrightText: 2026 Yuu Koizumi
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目のテスト 失敗"
    res=1
}

res=0

### NORMAL INPUT ###
out=$(printf "10\n10\n10\n10\n10\n10\n10\n10\n10\n100\n" | ./outlier)
[ "$?" = 0 ] || ng "$LINENO"
expected=$(printf "10\n10\n10\n10\n10\n10\n10\n10\n10")
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(printf "10 10 10 10 10 10 10 10 10 100\n" | ./outlier -s 3.5)
[ "$?" = 0 ] || ng "$LINENO"
expected=$(printf "10\n10\n10\n10\n10\n10\n10\n10\n10\n100")
[ "${out}" = "${expected}" ] || ng "$LINENO"

out=$(printf "5\n5\n5\n" | ./outlier)
[ "$?" = 0 ] || ng "$LINENO"
expected=$(printf "5\n5\n5")
[ "${out}" = "${expected}" ] || ng "$LINENO"

### STRANGE INPUT ###
out=$(echo "あ" | ./outlier 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo | ./outlier 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(printf "1\n2\n3\n" | ./outlier -s 0 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
