---
status: template
fill-with: /project-setup
---

# Deployment Skills

<!-- prompt: this doc is where YOU list the skills and review/analysis subagents the deployment
     and release/compliance roles are allowed to use (CI/CD helpers, release-packaging checks,
     store-compliance reviewers, etc.). The agents reference it instead of hard-coding tool
     names. Add or remove entries freely. -->

Every entry below is **advisory**: a skill or subagent suggestion is informative only. Where its
output conflicts with the house conventions in this domain's other docs (infrastructure, CI/CD,
release checklist), the house conventions win — unless you list it under "Authoritative Overrides".

<!-- prompt: RECOMMENDED starting skills for these roles, generalized from a working setup.
     /project-setup proposes concrete matches from whatever skill marketplaces you have
     installed (e.g. ECC subagents). Keep, drop, or swap any of them; move the ones you adopt
     down into the sections below. -->
## Recommended

<!--
- build-error resolvers matching your backend and frontend stacks (e.g. the ECC `<stack>-build-resolver`)
- a security reviewer for pipeline/config and the release surface (e.g. ECC `security-reviewer`)
- a store-compliance review skill before a mobile submission (e.g. `mobile-store-review`)
-->

<!-- prompt: implementation/generation skills this role should invoke, each with a when-to-use
     trigger. Example: "- pipeline/config helper — when changing CI/CD or infra config." -->
## Skills

<!-- prompt: review or analysis subagents to consult as a second opinion, each with a trigger.
     Example: "- release/compliance reviewer — before a release candidate is submitted." -->
## Review Subagents

<!-- prompt: list any skill/subagent whose output OVERRIDES the house conventions (rare). Leave
     empty if none — the default is that every entry above is advisory. -->
## Authoritative Overrides
