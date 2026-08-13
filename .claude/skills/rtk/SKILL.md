---
name: rtk
description: Reference for RTK, the optional terminal-output compression proxy that wraps noisy shell commands and caps their output. Use when you need the RTK meta-commands or want to understand how command output is being reduced. Full detail lives in docs/workflow/rtk.md.
---

# rtk

RTK is an **optional** machine-level tool that proxies noisy shell commands and caps their
output to keep agent context small. It is transparent: normal commands are rewritten by a
hook, so you rarely call `rtk` directly. Full behavior, rationale, and the command reference:
`docs/workflow/rtk.md`.

## Meta-commands (call `rtk` directly)

- `rtk gain` — show token-savings analytics.
- `rtk gain --history` — usage history with savings.
- `rtk discover` — analyze history for missed opportunities.
- `rtk proxy <cmd>` — run a raw command without filtering (for debugging).

## Rules

- Do not bypass the proxy to dodge output caps.
- If a wrapped command's output looks truncated, that is expected — re-run via
  `rtk proxy <cmd>` only when you genuinely need the full stream.
- RTK is not required for the framework to work; it only reduces token cost. See
  `docs/workflow/rtk.md` for install/verification.
