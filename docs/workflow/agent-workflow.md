# Agent Workflow — Manager, Advisor, and Specialist Pipeline

This is the deep-dive `CLAUDE.md` points to for how work actually moves through roles: the
core pipeline every task follows, the command layer that routes work to a cheaper or a
stronger model as needed, and the escalation files that carry a decision between them. Read
`CLAUDE.md`'s Development Workflow and AI Command Workflow sections first — this file
elaborates both without adding new rules.

## Roles at a Glance

- **Manager** — the only role that receives a request directly from a human. Understands
  the request, breaks it into task files, assigns exactly one owner per file, monitors
  execution, reviews the result, and updates vault-only documentation and memory. Never
  touches implementation output itself — see Manager Execution Boundary below.
- **Advisor** — a senior reasoning pass invoked only for complex or high-ambiguity work,
  intended for a stronger reasoning model than routine execution needs. Reads the escalation
  context, produces a recommendation, and stops. Never writes implementation output or
  assigns work directly.
- **Specialist(s)** — the roles defined in `agents/*.md` that actually do the work: plan,
  implement, verify, document, and report back inside the task file. Each task has exactly
  one specialist owner.

## The Core Pipeline

Every piece of work — no matter how small — moves through the same seven stages, with no
stage skipped:

```
User Request
    ↓
Manager                 (understands the goal, checks memory/ and docs/ first)
    ↓
Task Breakdown           (one task file per unit of work, one owner each)
    ↓
Specialist Execution     (plan → implement → verify)
    ↓
Review                   (Manager checks output against the task's success criteria)
    ↓
Documentation Update     (docs/ and knowledge/ reflect the new reality)
    ↓
Memory Update            (decisions, changelog, lessons learned)
```

**User Request → Manager.** The Manager is the single entry point for humans. It reads
lightweight context first — `memory/current-state.md` and the latest changelog/decisions
entries — rather than the full project history, and produces a short read on what's being
asked before deciding anything.

**Task Breakdown.** The Manager turns the request into one or more task files (see Task
Assignment & Lifecycle below), each with exactly one owner. A request that touches multiple
roles becomes multiple task files with explicit `DEPENDS ON` ordering between them, never one
file with more than one owner.

**Specialist Execution.** The assigned role reads its task file, its own role file, and the
specific documents the task points to — then plans (a short list of files it intends to
touch, written into the task file before the first edit), implements, and verifies the
result actually behaves as intended. "Should work" is never reported as done; the role must
have observed the change working.

**Review.** The Manager checks the specialist's report against the task's stated success
criteria — not against its own re-reading of every diff. This is why the report inside the
task file matters: it's what makes review possible without redoing the work.

**Documentation Update / Memory Update.** Both happen before a task is considered closed, not
as an optional follow-up. A task that satisfies its technical requirement but skips these two
stages is incomplete, per `CLAUDE.md`'s Definition of Done.

## Manager Execution Boundary

The Manager role is never an implementation role, and this holds even when a fix looks
trivial. The reasoning: every implementation change should exist because a task file said so
— that's what lets a future agent (or a human) reconstruct why a change happened purely from
the vault, with no side channel. The moment a Manager "just fixes it" directly, that
reconstructability breaks, and the boundary between "deciding what to do" and "doing it" —
which is what makes review meaningful — collapses.

If a Manager session catches itself thinking any of the following, it's about to cross the
line and should stop and delegate instead: *"this is just one line," "it's faster to fix it
myself," "no specialist role really fits this," "it's too trivial for a task file," "the
user is waiting so I'll just do it."* None of these shrink the requirement — they shrink only
the length of the task description.

## The Command Layer: `/manager-new` → `/advisor-take-over` → `/manager-continue`

A lightweight command layer sits on top of the pipeline above — it does not replace it, it
routes the *first* stage of the pipeline (Manager analysis) to the cheapest model capable of
handling it, and escalates to a stronger one only when the work genuinely needs it.

```
/manager-new
    ↓
Manager: Request Understanding / Impact Analysis / Complexity Assessment
    ↓                                            ↓
 simple / medium                          complex / high-ambiguity
    ↓                                            ↓
proceed directly                    write memory/advisor-context.md, STOP
                                                  ↓
                                        /advisor-take-over
                                                  ↓
                             Advisor reads advisor-context.md + the
                             specific files it points to (nothing else)
                                                  ↓
                             writes memory/advisor-decisions.md, STOPS
                                                  ↓
                                        /manager-continue
                                                  ↓
                     Manager reads advisor-decisions.md, plans within it,
                     creates task file(s), assigns specialist role(s)
                                                  ↓
                     normal pipeline resumes: Specialist Execution →
                     Review → Documentation Update → Memory Update
```

- **`/manager-new`** starts a request. The Manager gathers light context only, produces the
  three-part assessment above, and either proceeds straight into Task Breakdown (simple or
  medium complexity) or escalates and stops (complex or high-ambiguity).
- **`/advisor-take-over`**, run on a stronger reasoning model, reads *only*
  `memory/advisor-context.md` and the files it explicitly lists — not the whole project.
  It writes its recommendation to `memory/advisor-decisions.md` and stops. It never creates
  task files, never assigns a specialist, and never touches implementation output.
- **`/manager-continue`** resumes on the routine model. The Manager reads the Advisor's
  decision, plans strictly within it, creates the task file(s), assigns the specialist
  role(s), and runs the rest of the pipeline through to Memory Update.

### Escalation Files

`memory/advisor-context.md` (Manager → Advisor) and `memory/advisor-decisions.md`
(Advisor → Manager) are **per-escalation working files**, not permanent record. Each is
overwritten by the next escalation, so treat them as scratch space that must be emptied out
before it's lost:

- `advisor-context.md` should contain the request framing, why it was escalated, and pointers
  to the specific docs/memory files the Advisor needs — not a copy of their contents.
- `advisor-decisions.md` should contain the recommendation and its reasoning, in enough
  detail for the Manager to plan from it without re-deriving the analysis.

Any durable outcome either file contains **must be copied into `memory/decisions.md`** (and
into the ADR log, where it's architectural) before the task the escalation supports is
considered complete — see Decision Recording below. The escalation files themselves are never
the system of record.

## Task Assignment & Lifecycle

The Manager creates exactly one file per task, in `tasks/backlog/` or directly in
`tasks/active/`, using the template defined in `CLAUDE.md` § How Tasks Are Assigned (frontmatter
plus `TASK` / `OWNER` / `OBJECTIVE` / `CONTEXT` / `FILES TO READ` / `FILES TO MODIFY` /
`EXPECTED RESULT` / `TESTING` / `DOCUMENTATION REQUIRED`). Lifecycle:

```
backlog/  →  active/ (Manager assigns)  →  owner appends "## Report"  →  Manager reviews  →  completed/
```

If a task is too large for one owner, the Manager splits it into multiple task files with an
explicit `DEPENDS ON: <task file>` ordering, rather than assigning more than one owner to a
single file. One task file always has exactly one owner — that's what keeps the report
attributable and the boundary between roles legible.

## How Agents Communicate

There is no side channel between roles — all communication happens by writing into the vault,
and no role should assume shared memory with any other session. A future agent with no access
to the current conversation must be able to reconstruct the full reasoning behind any change
from the files alone. In practice: a specialist reports back inside its own task file by
appending a `## Report` section (what was done, files touched, docs updated, open questions);
cross-role questions route back through the Manager via the task file rather than a specialist
silently expanding into another role's territory; and a blocked role writes a `## Blocked`
section stating exactly what it needs and from whom, then stops rather than guessing.

## Decision Recording

A decision doesn't exist until it's written down, and it's written in two places within the
same task: the ADR log (numbered entries, statuses `Proposed → Accepted → Superseded`) and a
durable entry in `memory/decisions.md` in the `Date / Decision / Reason / Alternatives /
Impact` format from `CLAUDE.md`. Product-level decisions (scope, positioning, priorities) go
in the product knowledge area instead of the technical ADR log. A superseded decision is
marked as such in place, never deleted — later agents need to see what used to be true and
why it changed, not just what's true now.

## See Also

- `workspace-guide.md` — where each of these files actually lives, and the tiers that
  determine whether they're tracked.
- `rtk.md`, `pxpipe.md` — optional tooling that sits underneath this pipeline without
  changing it.
