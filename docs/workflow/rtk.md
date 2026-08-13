# RTK — Terminal Output Optimization

**Status: optional machine tool.** RTK is not required by the framework's roles or pipeline.
`CLAUDE.md`'s Terminal Output Optimization section describes the rule that assumes a layer
like this may exist; this file documents one concrete implementation of it. If RTK isn't
installed on the machine a session is running on, the pipeline still works — an agent just
has to be more deliberate about summarizing raw shell output itself instead of relying on a
wrapper to do it.

## What RTK Is

RTK is a terminal-output compression tool: it wraps common, noisy shell and tool commands and
caps or filters their output before that output ever reaches an agent's context. The goal is
to keep routine operations (status checks, searches, log inspection, diffs) from silently
consuming a large share of the context budget every time they're run.

## It's a Global, Machine-Level Hook

RTK is installed once per machine, not once per project. It sits at the harness level and
rewrites qualifying commands transparently — an agent invoking a normal command gets the
filtered, capped version automatically, at no extra context cost for the rewriting itself.
Because it's machine-level, whether it's present or not is a property of the environment a
session happens to be running in, not a property of this repository.

## Meta-Commands

A small set of commands manage RTK itself and are always invoked directly (never rewritten):

- **`rtk gain`** — shows token-savings analytics for the current install: how much output
  volume has been avoided by wrapping.
- **`rtk gain --history`** — shows command usage history alongside the savings each command
  produced, useful for seeing which operations benefit most from wrapping.
- **`rtk discover`** — analyzes an agent's own recent command history to surface missed
  opportunities: operations that could have been wrapped but weren't, so the wrapping rules
  can be tightened over time.
- **`rtk proxy <cmd>`** — executes a command with no filtering at all, for the case where the
  wrapped output is genuinely insufficient and the raw form is needed for debugging.

## The "Don't Bypass" Rule

Agents must not reach for raw, unwrapped output just because it's more familiar or feels
safer — the wrapped form is the default, and it's designed to still contain what a task needs
in the common case. Bypass it (via `rtk proxy` or another route) only when the filtered
output is verifiably insufficient for the task at hand, and say so explicitly when doing it,
rather than quietly working around the proxy. This mirrors `CLAUDE.md`'s Terminal Output
Optimization rule directly — this file doesn't add a new constraint, it just gives the rule a
concrete tool to point at.

## Verifying It's Present

Before relying on RTK in a session, confirm it's actually installed on this machine:

```bash
rtk --version     # should print a version, not "command not found"
rtk gain          # should return analytics, not an error
which rtk         # confirm the binary resolved is actually RTK
```

If any of these fail, treat RTK as absent for this session and proceed without it — it's
optional tooling, not a workflow dependency. (Watch for name collisions: a different tool
that happens to share the `rtk` binary name is not this tool, and `rtk gain` failing while
`rtk` itself runs is the tell.)

## See Also

- `workspace-guide.md` § Context Optimization Rules — where this tool fits relative to the
  framework's own context discipline.
- `pxpipe.md` — the session-level counterpart that compresses transport rather than terminal
  output.
