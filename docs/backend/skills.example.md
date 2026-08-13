---
status: template
fill-with: /project-setup
---

# Backend Skills

<!-- prompt: this doc is where YOU list the skills and review/analysis subagents the backend
     role is allowed to use. The agent references it instead of hard-coding tool names. Add or
     remove entries freely — this is the single place to wire the backend role to its tooling. -->

Every entry below is **advisory**: a skill or subagent suggestion is informative only. Where its
output conflicts with the house conventions in this domain's other docs, the house conventions win —
unless you deliberately list it under "Authoritative Overrides".

<!-- prompt: RECOMMENDED starting skills for this role, generalized from a working setup.
     /project-setup proposes concrete matches from whatever skill marketplaces you have
     installed (e.g. ECC subagents, Taste skills). Keep, drop, or swap any of them; move the
     ones you adopt down into the sections below. -->
## Recommended

<!--
- a build/compile-error resolver matching your backend stack (e.g. the ECC `<stack>-build-resolver`)
- a code reviewer matching your backend language/framework (e.g. the ECC `<stack>-reviewer`)
- a security reviewer for anything handling untrusted input, auth, or sensitive data (e.g. ECC `security-reviewer`)
-->

<!-- prompt: implementation/generation skills this role should invoke, each with a when-to-use
     trigger. Example format: "- `add-endpoint` — when adding a new server endpoint." -->
## Skills

<!-- prompt: review or analysis subagents to consult as a second opinion, each with a trigger.
     Example: "- backend code reviewer — after any change to route/validation/data-access code." -->
## Review Subagents

<!-- prompt: list any skill/subagent whose output OVERRIDES the house conventions (rare). Leave
     empty if none — the default is that every entry above is advisory. -->
## Authoritative Overrides
