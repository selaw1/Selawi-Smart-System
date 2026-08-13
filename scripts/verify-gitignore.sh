#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
fail=0
check_ignored()   { git check-ignore -q "$1" && echo "OK ignored:  $1" || { echo "FAIL expected-ignored: $1"; fail=1; }; }
check_tracked()   { git check-ignore -q "$1" && { echo "FAIL expected-tracked: $1"; fail=1; } || echo "OK tracked:  $1"; }

# templates are tracked
check_tracked docs/backend/stack.example.md
check_tracked memory/current-state.example.md
check_tracked secrets/README.example.md
# filled copies are ignored
check_ignored docs/backend/stack.md
check_ignored memory/current-state.md
# product repo + secret + local settings ignored
mkdir -p Backend/.git secrets/apple
check_ignored Backend/whatever.py
check_ignored secrets/apple/key.p8
check_ignored .claude/settings.local.json
# framework workflow docs stay tracked
check_tracked docs/workflow/rtk.md
rm -rf Backend secrets/apple
exit $fail
