# Selawi Smart System (S³)

A standalone, reusable, git-distributable **multi-agent workspace framework** for any tech
stack. A `/project-setup` interview turns this skeleton into a configured, pull-safe
workspace: a Manager agent triages requests, specialist agents implement, and an Obsidian
second brain (optional) holds all knowledge, decisions, and memory.

S³ is **tech-agnostic**. There are no framework, language, or tool names baked into the
core — your stack is described in project docs during setup.

## The three-tier model

Files fall into three tiers, and the ignore rules keep the framework safe to `git pull`:

| Tier | What | Git status |
|---|---|---|
| 🧱 **Framework** | The skill code, harnesses, workflow docs, agent role files | **tracked** — updated by `git pull` |
| 📋 **Templates** | Every `*.example.md` documentation/memory skeleton | **tracked** — the pull-safe source |
| 🗂️ **Project state** | Your filled `*.md` docs, memory, product repos, secrets | **gitignored** — never overwritten by a pull |

Because your filled files are gitignored and only the `*.example.md` templates are tracked,
pulling a new framework version never clobbers your project's content. See "Updating" below.

## Prerequisites

| Tool | Required? | What it's for | Install |
|---|---|---|---|
| Claude Code | Required | Runs the agents and skills | https://docs.claude.com/claude-code |
| Superpowers plugin | Required | Planning / execution / subagent skills | https://github.com/obra/superpowers |
| RTK | Optional | Terminal-output compression proxy (token savings) | see `docs/workflow/rtk.md` |
| PXPipe | Optional | Context/transport compression | see `docs/workflow/pxpipe.md` |
| Obsidian | Optional | Browse the vault as a linked second brain | https://obsidian.md |

## Machine setup (once per machine)

```bash
git clone <this-repo-url> "Selawi Smart System"
cd "Selawi Smart System"
```

Machine-specific Claude Code config goes in the **gitignored** `.claude/settings.local.json`
— never in the tracked `.claude/settings.json`.

## New project

Run the one-time interview inside Claude Code:

```
/project-setup
```

It detects which agents you want, materializes and fills only the docs those agents
reference, wires optional layers (Obsidian, example skills), and verifies ignore state.

## Daily use

Start every request with the Manager:

```
/manager-new
```

The Manager triages, creates task files in `tasks/active/`, and hands off to specialists.

## Updating the framework

`git pull` is **pull-safe**: it only updates tracked framework files and `*.example.md`
templates. Your filled project docs, memory, secrets, and product repos are gitignored, so a
pull can never overwrite them. If a template gains new sections after a pull, re-run the
relevant part of `/project-setup` to fold them into your filled copy.

## Nested product repositories (safety)

Your actual code repos (backend, frontend, …) live in **subfolders that keep their own
`.git`** and are listed in `.gitignore`. **Never `git add` a folder that contains its own
`.git`** — that creates a gitlink/submodule trap. `/project-setup` adds these folders to
`.gitignore` for you; `scripts/verify-gitignore.sh` proves it.

## Skills

- `/project-setup` — one-time setup interview.
- `/manager-new` — start a new request (Manager triage).
- `/advisor-take-over` — senior reasoning review for Complex requests.
- `/manager-continue` — resume implementation after an Advisor decision.
- `rtk` — reference for the optional terminal-output proxy.
- `.claude/skills/examples/*` — stack-neutral skeletons to copy up and customize.

## License

MIT. See `LICENSE`.
