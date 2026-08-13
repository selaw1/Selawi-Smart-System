#!/usr/bin/env bash
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
out=$(bash .claude/skills/project-setup/lib/parse-refs.sh agents/Backend-Agent.md)
expected=$'@docs/backend/stack.md\n@docs/backend/conventions.md\n@docs/backend/api-patterns.md\n@docs/database/schema.md'
[ "$out" = "$expected" ] && echo "PASS parse-refs" || { echo "FAIL parse-refs"; printf 'got:\n%s\n' "$out"; exit 1; }
