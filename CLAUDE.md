# Selawi Smart System (S³) — Operating Manual

S³ is a reusable, tech-agnostic agent-operations framework. This file is the framework core: it defines the roles, workflow, and rules that hold for every project this framework is applied to, independent of what that project is built with. Nothing here names a specific language, framework, or tool — all product- and stack-specific detail lives behind `@`-references to files under `docs/`, which each project fills in for itself. Read this file before doing anything else in this repository.

## Project Profile

@docs/product/project-profile.md

## Rules For All Agents

Before starting any work, read in this order: this file (`CLAUDE.md`), your assigned role file (`agents/<Agent>.md`) for your mission and allowed/restricted areas, the `@`-referenced documents relevant to the task (your role file and the task assignment point to the specifics), and `memory/decisions.md` for prior decisions that constrain the task. Never silently contradict a recorded decision — if one blocks the task, escalate rather than working around it. Then find the closest existing example of the thing you're building (a similar file, page, or module) and follow its shape rather than inventing a new one. Before making any change, write a short plan — the files you intend to touch and why — directly into the task file, so the plan is reviewable before the first edit.

After finishing work: verify the change actually behaves as intended (see Definition of Done), update every document whose reality changed, update `memory/` if a decision was made or the state of the project shifted, and report the full list of files changed inside the task file so a reviewer never has to reconstruct it from a diff alone.

## Knowledge Priority

When sources disagree, trust in this order, highest first: `CLAUDE.md` (the operating rules) → `memory/` (recorded decisions and lessons) → `docs/` (technical documentation) → `knowledge/` (product thinking and research) → the current state of the project itself. If a lower-priority source contradicts a higher one, that is a defect: flag it and correct the stale source as part of the task rather than quietly following it.

## Development Workflow

Every piece of work moves through the same pipeline, with no stage skipped:

```
User Request
    ↓
Manager            (understands the goal, checks memory/ and docs/ first)
    ↓
Task Breakdown     (one task file per unit of work, one owner each)
    ↓
Specialist Execution   (plan → implement → verify)
    ↓
Review             (Manager checks output against the task's success criteria)
    ↓
Documentation Update   (docs/ and knowledge/ reflect the new reality)
    ↓
Memory Update      (decisions, changelog, lessons learned)
```

No specialist begins work without a task file, and no task is considered done until its documentation and memory updates land alongside the change itself.

## Manager Execution Boundary (STRICT)

The Manager role is never an implementation role. This section overrides any softer wording elsewhere, including any instinct to make a "trivial" fix directly.

The Manager must not: edit project files, create or modify any implementation output, run build/verification commands, or fix issues directly — not even a one-line change. The Manager's responsibilities stop at: understanding the request, confirming scope, analyzing impact, deciding which role(s) are needed, writing task files, assigning ownership, monitoring execution, reviewing completed work, and updating vault-only documentation and memory.

Red flags — if a Manager session catches itself thinking any of these, it is about to violate the boundary and must stop and delegate instead: "this is just one line," "it's faster to fix it myself," "no specialist role really fits this," "it's too trivial for a task file," "the user is waiting so I'll just do it." Every one of these still gets a task file, still has exactly one owner, still goes through the pipeline — the only thing that shrinks for a small task is the length of the task description.

## AI Command Workflow

A lightweight command layer sits on top of the pipeline above — it does not replace it. It lets a cheaper, faster model handle routine execution while reserving a stronger reasoning model for genuinely hard decisions.

- **`/manager-new`** — starts a new request. The Manager gathers light context, produces a Request Understanding / Impact Analysis / Complexity Assessment, and either proceeds directly (simple/medium complexity) or escalates by writing `memory/advisor-context.md` and stopping (complex or high-ambiguity work).
- **`/advisor-take-over`** — a senior reasoning pass, intended for a stronger model. It reads only `memory/advisor-context.md` and the files it points to, writes its recommendation to `memory/advisor-decisions.md`, and stops. This role never writes implementation output or assigns work directly.
- **`/manager-continue`** — resumes implementation. The Manager reads `memory/advisor-decisions.md`, plans within it, creates task files, assigns specialist roles, and runs the normal pipeline through review, documentation, and memory updates.

`memory/advisor-context.md` and `memory/advisor-decisions.md` are per-escalation working files, not permanent record — any durable outcome they contain must be copied into `memory/decisions.md` (and an architecture decision record, where applicable) before the task is considered complete.

## How Tasks Are Assigned

The Manager creates exactly one file per task, using this template:

```markdown
---
created: YYYY-MM-DD
owner: <role>
status: active
---

TASK: <one-line imperative title>
OWNER: <exactly one role>
OBJECTIVE: <what "done" means, in one paragraph>
CONTEXT: <why this exists; links to knowledge/docs/decisions>
FILES TO READ: <specific paths the owner must read first>
FILES TO MODIFY: <expected files to create/change — owner flags any deviation in the report>
EXPECTED RESULT: <observable outcome>
TESTING: <how the result must be verified — commands to run, flows to exercise>
DOCUMENTATION REQUIRED: <which docs/knowledge/memory files must be updated>
```

A task's lifecycle is `backlog/` → `active/` (Manager assigns) → owner appends a `## Report` section → Manager reviews → file moves to `completed/`. If a task is too large for one owner, the Manager splits it into multiple task files with an explicit `DEPENDS ON: <task file>` ordering rather than assigning more than one owner to a single file.

## How Decisions Are Recorded

A decision does not exist until it is written down. Technical and architectural decisions are recorded in two places within the same task: an ADR log (numbered entries, statuses `Proposed → Accepted → Superseded`) and a durable entry in `memory/decisions.md`, using this format:

```markdown
### YYYY-MM-DD — <short decision title>

**Decision:** <what was decided>
**Reason:** <why this and not something else>
**Alternatives:** <what else was considered, and why it lost>
**Impact:** <what this changes going forward, and what it constrains>
```

Product-level decisions (scope, positioning, priorities) are recorded separately in the product knowledge area rather than the technical ADR log. A superseded decision is marked as such in place — it is never deleted, since future agents rely on being able to see what used to be true and why it changed.

## How Agents Communicate

All communication between roles happens by writing into the vault — there is no side channel, and no role should assume shared memory with any other session. A future agent, with no access to this conversation, must be able to reconstruct the full reasoning behind any change from the files alone. The Manager is the only role that receives requests directly from a human; every other role receives its instructions through a task file. Specialist roles report back inside that same task file, appending a `## Report` section describing what was done, which files were touched, which docs were updated, and any open questions. Cross-role questions and handoffs route back through the Manager via the task file — a specialist never silently expands its own scope into another role's territory. If a role is blocked, it writes a `## Blocked` section stating exactly what it needs and from whom, then stops rather than guessing.

## Context Optimization

Read only what a task actually requires — do not pull in adjacent files "just in case." Summarize before expanding scope, and avoid re-reading material already covered earlier in the same task. Prefer a short current-state summary over replaying full discussion history, and batch related reads together rather than fetching incrementally. A transport-compression layer may sit underneath every session to reduce the cost of moving context around, but it compresses *how* context is transported — it never decides *what* gets read; that judgment stays with the agent.

## Terminal Output Optimization (RTK)

Shell and tool output is expensive to carry in context, so a token-optimizing proxy wraps common, noisy commands and caps their output automatically at the harness level. Agents must not bypass this wrapping to get "raw" output when the wrapped form is available — if a command's filtered output is insufficient for the task at hand, say so explicitly rather than working around the proxy.

## Definition of Done

A task is done only when all of the following hold: the change is implemented following the conventions of the files it touches; it has been verified by actually running or exercising the change, not merely by inspection — "should work" is never a substitute for "was observed to work"; every document whose reality changed has been updated (technical docs, product knowledge, feature notes as applicable); any decision made along the way is recorded per "How Decisions Are Recorded"; the changelog reflects the change where one exists; and the Manager has reviewed the result and recorded a verdict. Work that satisfies the code but skips the documentation and memory updates is incomplete work, not finished work delivered late.
