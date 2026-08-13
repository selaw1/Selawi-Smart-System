---
name: project-setup
description: One-time interview that turns the Selawi Smart System (S³) framework skeleton into a configured workspace for a specific project. Detects the chosen agents, materializes and fills the documentation/memory templates they reference, prunes what isn't wanted, wires optional layers, and verifies pull-safe ignore state. Run once, right after cloning the framework.
---

# project-setup

You are running the **one-time setup interview** that adapts this framework repo to a
concrete project. You ONLY write files and ask questions. You run **no product builds**, you
touch **no product-repo contents**, and you **do not `git commit` without asking** the user.

Work through the 11 steps in order. Ask before anything destructive.

## Step 1 — Idempotency check

Detect already-filled files: for any `docs/**/*.md` (or `memory/*.md`) that exists alongside
its `*.example.md` sibling, treat setup as already run for that file and **skip it**. Never
overwrite a filled file. Report which parts are already configured.

## Step 2 — Choose agents

List the role files in `agents/`. Ask the user which roles this project actually needs.
`rm` the agent files for roles they don't want. Keep exactly the chosen set.

## Step 3 — Materialize & fill the docs each agent references

For each chosen agent file, run `lib/parse-refs.sh agents/<Agent>.md` to get its
`@docs/...md` reference paths (one per line). For each path `docs/X/Y.md`:

- `cp docs/X/Y.example.md docs/X/Y.md`
- Interview the user section by section (the `.example` files carry `<!-- prompt: ... -->`
  guidance) and fill the real `docs/X/Y.md`.

Only materialize the templates the chosen agents actually reference — this is why setup is
driven by `parse-refs`, not a blanket copy.

When a `docs/<domain>/skills.md` template has a `## Recommended` block, read its role-based
suggestions and, using the stack from Step 4, propose concrete matching skills from whatever
marketplaces the user has installed (e.g. ECC subagents, Taste skills) — e.g. a backend
`<stack>-reviewer`, a `<stack>-build-resolver`. Wire the ones the user accepts into the
`## Skills` / `## Review Subagents` sections; leave the rest out. These are suggestions, not
defaults — never wire a skill the user didn't confirm, and never assume a marketplace is installed.

## Step 4 — Project profile

Fill `docs/product/project-profile.md` from `docs/product/project-profile.example.md`,
including the Tech-Stack table that `CLAUDE.md` imports via its `@`-reference.

## Step 5 — Memory

Copy `memory/*.example.md` → `memory/*.md`. Then write an initial
`memory/current-state.md`, and a first entry in `memory/changelog.md` and
`memory/decisions.md` reading `initialized from S³ v$(cat VERSION)`.

## Step 6 — Knowledge

Ask which `knowledge/` categories to keep (Decisions, Features, Ideas, Research, Product,
Marketing, …). `rm -rf` the categories they don't want.

## Step 7 — Example skills

For each folder under `.claude/skills/examples/`, ask whether the project wants it. If yes,
copy it up into `.claude/skills/` and tell the user to customize it for their stack.

## Step 8 — Obsidian (optional)

Ask "Enable Obsidian?". If yes, `cp -r obsidian/.obsidian.example .obsidian` (the copy is
gitignored as local, machine-specific state). If no, leave it.

## Step 9 — Nested product repos

Ask for the folder names of any nested product repositories (e.g. a backend or frontend
subfolder that has its own `.git`). Append a `/<Name>/` line for each to `.gitignore` so the
framework repo never stages product-repo contents (avoids the submodule/gitlink trap).

## Step 10 — Verify ignore state

Run `scripts/verify-gitignore.sh`. Confirm every materialized `*.md` is ignored and every
`*.example.md` is still tracked. Do **NOT** rewrite git history. If anything is wrong, fix
the `.gitignore` rule, not the history.

## Step 11 — Finish

Print a summary of what was configured (agents kept, docs filled, knowledge kept, optional
layers enabled) and tell the user the next command is **`/manager-new`** to start their
first request.

## Hard rule (repeat to yourself)

The setup skill only writes files and asks questions. No product builds, no product-repo
edits, no committing without explicit confirmation.
