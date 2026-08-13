# Workspace Guide — Folders, Tiers, and Context Rules

This is the deep-dive `CLAUDE.md` points to for the workspace layout: what each top-level
folder is for, which files are permanently tracked versus per-project fill-ins, and how to
keep a session's context small on purpose rather than by accident. Read `CLAUDE.md` first —
this file elaborates it, it does not replace it.

## Folder-Structure Tour

| Folder | Purpose |
|---|---|
| `CLAUDE.md` | The framework core — roles, pipeline, rules. Always read first. |
| `agents/` | One role file per role (`<Role>.md`). Mission and allowed/restricted areas only — no stack specifics. |
| `docs/` | Technical documentation, organized by domain (`backend/`, `frontend/`, `database/`, `deployment/`, `qa/`, `product/`, `workflow/`). Everything project- or stack-specific lives here, `@`-referenced from role files and task files rather than inlined. |
| `docs/workflow/` | The exception: framework tooling docs (this file and its three siblings) rather than project fill-ins — see Tiers below. |
| `knowledge/` | Product thinking and research: `Decisions/`, `Features/`, `Ideas/`, `Marketing/`, `Product/`, `Research/`. Durable product context that outlives any one task. |
| `memory/` | The project's working memory: `decisions.md`, `changelog.md`, `current-state.md`, `lessons-learned.md`, plus the transient escalation files `advisor-context.md` / `advisor-decisions.md`. |
| `tasks/` | The task-file lifecycle: `backlog/` → `active/` → `completed/`. |
| `scripts/` | Repo-maintenance scripts, e.g. the tier-integrity check (`verify-gitignore.sh`). |
| `secrets/` | Local credential material. Never tracked beyond its own `.gitignore`. |
| `obsidian/` | Vault viewer configuration for browsing this repository as a knowledge base. |
| `.claude/` | Harness configuration and skills; `settings.local.json` inside it is machine-local and never tracked. |

## The Three Tracking Tiers

The `.gitignore` encodes three tiers of "how permanent is this file", not one blanket
ignore rule. Knowing which tier a file is in tells you whether editing it is a framework
change (rare, deliberate, reviewed) or routine project record-keeping (constant, expected).

**🟦 Tier 1 — Framework core, always tracked.**
`CLAUDE.md`, `agents/*.md`, `docs/workflow/**` (this doc and its three siblings), `scripts/`,
`LICENSE`, `VERSION`, and the shared `.claude/skills/` content. This is the framework itself —
what any project adopting it gets out of the box. Changes here affect every project built on
top of this repository, so they're deliberate and infrequent.

**🟨 Tier 2 — Project templates, tracked as `*.example.md` only.**
Every domain folder under `docs/` and `memory/` follows the same pattern: a filled `*.md` is
gitignored (it's this project's actual, evolving record), while its `*.example.md` sibling is
always tracked (it's the reusable template new projects copy from). `tasks/**` and
`knowledge/**` keep their directory structure tracked via `.gitkeep` while their contents stay
ignored — the shape of the workspace is part of the framework, the content inside it is not.

**🟥 Tier 3 — Never tracked.**
`secrets/**` (except its own `.gitignore`), `.claude/settings.local.json`, `.obsidian/`, and any
nested product repository folders (a nested `.git` must never be staged into this one — that's
the gitlink/submodule trap). Nothing in this tier belongs in version control under any
circumstance, project-specific or not.

Run `scripts/verify-gitignore.sh` if you're unsure whether a new file lands in the tier you
expect — it's a pull-safety fixture check, not a build gate, but it catches the case where a
filled project file would otherwise leak into the tracked framework core.

## Context Optimization Rules

Context is a shared, finite resource across every role in a session — treat reading it as a
cost, not a default.

- **Read only what the task requires.** A task file names the files its owner must read;
  don't pull in adjacent files "just in case" they're relevant.
- **Summarize before expanding.** When a file is long, read the section you need and
  summarize the rest rather than loading the whole thing into context "to be safe."
- **Never re-read what's already been covered** earlier in the same task — if you already
  have the content, use it.
- **Prefer `memory/current-state.md` over full history.** When resuming or picking up a
  task, read the short current-state summary before reaching for `memory/changelog.md` or
  the full decision log — expand into history only if the summary doesn't answer the
  question.
- **Batch related reads.** Fetch the files a step needs together, in one pass, rather than
  discovering and re-reading incrementally as you go.

Two optional machine-level tools sit underneath this discipline and are documented
separately because they're tooling, not workflow rules: `rtk.md` compresses noisy terminal
output before it reaches context; `pxpipe.md` compresses how a whole session's context is
transported. Neither one decides *what* an agent reads — that judgment always stays with the
agent, per the rule above. Treat both as accelerants you may not have installed, not as
things the workflow depends on.

## Where Knowledge Lives

- **`docs/`** — the technical record: how the system is built, one domain per folder,
  filled in per project from the `*.example.md` templates.
- **`knowledge/`** — the product record: why things are the way they are, ideas under
  consideration, competitive/market research, and marketing-facing material — the kind of
  context that survives long after a given task is closed.
- **`memory/`** — the operational record: decisions actually made (`decisions.md`), what
  changed and when (`changelog.md`), what's true right now in one short page
  (`current-state.md`), and mistakes worth not repeating (`lessons-learned.md`).
- **`tasks/`** — the execution record: one file per unit of work, its plan, and its report,
  moving from `backlog/` to `active/` to `completed/` as it's picked up and finished.

When two of these disagree, `CLAUDE.md`'s Knowledge Priority order settles it — this file
doesn't change that order, it only tells you where to look for each kind of thing.

## See Also

- `agent-workflow.md` — the Manager → Advisor → specialist pipeline in detail.
- `rtk.md` — terminal-output compression (optional).
- `pxpipe.md` — session transport/context compression (optional).
