#!/usr/bin/env bash
# Usage: parse-refs.sh <agent-file>. Prints each @docs/...md reference line verbatim, in order.
set -euo pipefail
grep -oE '@docs/[A-Za-z0-9/_-]+\.md' "$1"
