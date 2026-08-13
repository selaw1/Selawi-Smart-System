# Obsidian layer (opt-in)

The repository root doubles as an Obsidian vault so the `docs/`, `knowledge/`,
`memory/`, and `agents/` folders can be browsed, linked, and graphed as a second brain.

This is **optional**. The framework works with plain Markdown and git alone — Obsidian
just makes navigation and backlinking nicer for humans.

## What's here

`.obsidian.example/` — a starter Obsidian configuration:

- `core-plugins.json` — enables the graph view, backlinks, outgoing links, search, and
  outline.
- `community-plugins.json` — lists `claude-code-ide` (open the vault and install it from
  Community Plugins to get the integration).
- `app.json` — minimal editor defaults (relative links, attachment folder).

## How to enable it

`/project-setup` asks whether you want the Obsidian layer. If you say yes, it copies
`.obsidian.example/` to `.obsidian/` (which is gitignored as local, machine-specific
state). To enable it manually:

```bash
cp -r obsidian/.obsidian.example .obsidian
```

Then open the repository root as a vault in Obsidian and enable the community plugin.
