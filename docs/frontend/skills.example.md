---
status: template
fill-with: /project-setup
---

# Frontend Skills

<!-- prompt: this doc is where YOU list the skills and review/analysis subagents the frontend
     and UI/UX roles are allowed to use. The agents reference it instead of hard-coding tool
     names (design-taste helpers, component reviewers, etc.). Add or remove entries freely. -->

Every entry below is **advisory**: a skill or subagent suggestion is informative only. Where its
output conflicts with the house conventions in this domain's other docs (design system, i18n,
layout direction), the house conventions win — unless you list it under "Authoritative Overrides".

<!-- prompt: RECOMMENDED starting skills for these roles, generalized from a working setup.
     /project-setup proposes concrete matches from whatever skill marketplaces you have
     installed (e.g. ECC subagents, Taste skills). Keep, drop, or swap any of them; move the
     ones you adopt down into the sections below. -->
## Recommended

<!--
- a build-error resolver matching your frontend stack (e.g. the ECC `<stack>-build-resolver`)
- a code reviewer for your UI framework and language (e.g. the ECC `<framework>-reviewer`, `typescript-reviewer`)
- design-taste / visual-polish helpers for new UI (e.g. Taste `design-taste-frontend`, `high-end-visual-design`, `redesign-existing-projects`)
- an accessibility reviewer for interactive components (e.g. ECC `a11y-architect`)
-->

<!-- prompt: implementation/generation skills this role should invoke, each with a when-to-use
     trigger. Example: "- `add-page` — when adding a new screen." "- design-taste helper — for
     visual polish on new UI." -->
## Skills

<!-- prompt: review or analysis subagents to consult as a second opinion, each with a trigger.
     Example: "- frontend/component reviewer — after any change to component or state code." -->
## Review Subagents

<!-- prompt: list any skill/subagent whose output OVERRIDES the house conventions (rare). Leave
     empty if none — the default is that every entry above is advisory. -->
## Authoritative Overrides
