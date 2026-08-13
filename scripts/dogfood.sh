#!/usr/bin/env bash
set -euo pipefail
S3_ROOT="$(git rev-parse --show-toplevel)"
WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT
# 1. simulate a workspace by cloning S³
git clone -q "$S3_ROOT" "$WORK/ws"; cd "$WORK/ws"
# 2. simulate a filled project: create filled docs + a product repo + a secret
cp docs/backend/stack.example.md docs/backend/stack.md
echo "FILLED-BY-USER" >> docs/backend/stack.md
mkdir -p Backend/.git; echo "print('x')" > Backend/app.py
echo '/Backend/' >> .gitignore
mkdir -p secrets; echo "TOPSECRET" > secrets/key.txt
# 3. assert filled state + product repo + secret are all ignored
for p in docs/backend/stack.md Backend/app.py secrets/key.txt; do
  git check-ignore -q "$p" || { echo "FAIL not-ignored: $p"; exit 1; }; done
echo "OK all project state ignored"
# 4. simulate an upstream framework update and pull
( cd "$S3_ROOT" && echo "0.1.1" > VERSION && git commit -q -am "chore: bump" )
before=$(sha256sum docs/backend/stack.md | cut -d' ' -f1)
git pull -q origin "$(git -C "$S3_ROOT" branch --show-current)"
after=$(sha256sum docs/backend/stack.md | cut -d' ' -f1)
[ "$before" = "$after" ] || { echo "FAIL pull clobbered filled stack.md"; exit 1; }
[ "$(cat VERSION)" = "0.1.1" ] || { echo "FAIL framework did not update"; exit 1; }
echo "OK pull updated framework (VERSION 0.1.1) and left filled stack.md byte-identical"
# 5. template/agent closure
cd "$S3_ROOT"
for ref in $(grep -rhoE '@docs/[A-Za-z0-9/_-]+\.md' agents/ | sort -u); do
  t="${ref#@}"; t="${t%.md}.example.md"; test -f "$t" || { echo "FAIL missing template $t"; exit 1; }; done
echo "OK agent/template closure holds"
echo "DOGFOOD-PASS"
