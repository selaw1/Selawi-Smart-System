---
status: template
fill-with: /project-setup
---

# Database Skills

<!-- prompt: this doc is where YOU list the skills and review/analysis subagents the database
     role is allowed to use (schema/migration helpers, query/index reviewers, etc.). The agent
     references it instead of hard-coding tool names. Add or remove entries freely. -->

Every entry below is **advisory**: a skill or subagent suggestion is informative only. Where its
output conflicts with the house conventions in this domain's other docs (schema shape, scoping,
migration safety), the house conventions win — unless you list it under "Authoritative Overrides".

<!-- prompt: RECOMMENDED starting skills for this role, generalized from a working setup.
     /project-setup proposes concrete matches from whatever skill marketplaces you have
     installed (e.g. ECC subagents). Keep, drop, or swap any of them; move the ones you adopt
     down into the sections below. -->
## Recommended

<!--
- a database/query reviewer for schema, query, and index changes (e.g. ECC `database-reviewer`)
-->

<!-- prompt: implementation/generation skills this role should invoke, each with a when-to-use
     trigger. Example: "- migration helper — when changing the schema." -->
## Skills

<!-- prompt: review or analysis subagents to consult as a second opinion, each with a trigger.
     Example: "- database/query reviewer — before shipping a new query or index." -->
## Review Subagents

<!-- prompt: list any skill/subagent whose output OVERRIDES the house conventions (rare). Leave
     empty if none — the default is that every entry above is advisory. -->
## Authoritative Overrides
