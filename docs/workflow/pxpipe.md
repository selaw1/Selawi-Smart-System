# PXPipe — Session Transport & Context Compression

**Status: optional, opt-in per session.** PXPipe is not required by the framework's roles or
pipeline, and it must never be treated as always-on infrastructure. `CLAUDE.md`'s Context
Optimization section already states the principle this tool implements: a transport-
compression layer may sit underneath a session to reduce the cost of moving context around,
but it compresses *how* context is transported — it never decides *what* gets read. That
judgment always stays with the agent.

## What PXPipe Is

PXPipe is a local proxy that sits between an agent session and the model API. It compresses
the context moving back and forth over the course of a session so that a given amount of
working context costs fewer bytes to transport per turn. It is a transport optimization, not
a reasoning or workflow change — a session behaves the same with or without it, aside from
what it costs to run.

## How It's Enabled: Opt-In, Per Session, Never Permanent

PXPipe works by pointing the environment variable the model client reads for its API base URL
at the local proxy's address instead of the default endpoint. This must be done **per
session, on demand, through a shell helper** — never as a permanent, exported setting, and
never written as a literal assignment inside any tracked file.

The reasoning: if the proxy is ever stopped or unavailable while the variable is still
pointed at it permanently, every session that inherits that environment breaks immediately,
with no fallback to the direct connection. Keeping it opt-in means the default is always the
direct, working connection, and PXPipe is something an agent or user turns on deliberately,
for a specific window of work, knowing the proxy needs to actually be running for it to help.

An illustrative shell-helper pattern (kept in a local, untracked shell profile or interactive
function — never committed to this repository, and never hardcoded as a standing export):

```bash
# opt-in helper — invoke manually for this session only; do not export permanently
pxpipe-on() {
  export ANTHROPIC_BASE_URL="http://<proxy-host>:<proxy-port>"
}
pxpipe-off() {
  unset ANTHROPIC_BASE_URL
}
```

Replace `<proxy-host>:<proxy-port>` with wherever the proxy actually listens on a given
machine — that value is machine-local configuration, not something this framework document
should ever pin to a literal address.

## The Lossy-Recall Caveat

Because PXPipe's job is to shrink how much of a session's context has to move per turn, older
parts of a long conversation are liable to be summarized or approximated rather than carried
byte-for-byte once they age out of the immediate window. That's an acceptable trade for
narrative context — what was discussed, why an approach was chosen — but it is **not**
acceptable for anything that has to match exactly.

**Rule:** never rely on compressed, older history for byte-critical values — keys, hashes,
IDs, tokens, exact file paths, or any string that must be reproduced precisely. If a value
like that was established earlier in a long session, re-state it in fresh text near where
it's actually used, or read it back from its source file, rather than trusting recall through
a compression layer to have preserved it exactly.

## Verifying Its State

Before assuming PXPipe is active — or assuming it's off — check the environment variable it
uses directly, rather than guessing from session behavior:

```bash
echo "${ANTHROPIC_BASE_URL:-<unset>}"
```

It should normally read `<unset>` between sessions. If it's set, confirm that was intentional
for the current window of work, and turn it off with the paired helper once that window is
done.

## See Also

- `workspace-guide.md` § Context Optimization Rules — the general principle this tool
  implements one piece of.
- `rtk.md` — the terminal-output counterpart; RTK filters command output, PXPipe compresses
  session transport. Neither one changes what an agent chooses to read.
