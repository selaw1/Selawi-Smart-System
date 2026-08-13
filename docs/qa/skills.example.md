---
status: template
fill-with: /project-setup
---

# QA Skills

<!-- prompt: this doc is where YOU list the skills and review/analysis subagents the QA role is
     allowed to use (test-generation helpers, coverage/risk analyzers, e2e runners, etc.). The
     agent references it instead of hard-coding tool names. Add or remove entries freely. -->

Every entry below is **advisory**: a skill or subagent suggestion is informative only. Where its
output conflicts with the house conventions in this domain's other docs (testing strategy), the
house conventions win — unless you list it under "Authoritative Overrides".

<!-- prompt: RECOMMENDED starting skills for this role, generalized from a working setup.
     /project-setup proposes concrete matches from whatever skill marketplaces you have
     installed (e.g. ECC subagents). Keep, drop, or swap any of them; move the ones you adopt
     down into the sections below. -->
## Recommended

<!--
- an end-to-end test runner for critical flows (e.g. ECC `e2e-runner`)
- a test-coverage / PR test analyzer after writing or changing tests (e.g. ECC `pr-test-analyzer`)
- a silent-failure / swallowed-error hunter (e.g. ECC `silent-failure-hunter`)
-->

<!-- prompt: implementation/generation skills this role should invoke, each with a when-to-use
     trigger. Example: "- test scaffolding helper — when adding tests for a new feature." -->
## Skills

<!-- prompt: review or analysis subagents to consult as a second opinion, each with a trigger.
     Example: "- test-coverage/risk analyzer — after writing or changing a test suite." -->
## Review Subagents

<!-- prompt: list any skill/subagent whose output OVERRIDES the house conventions (rare). Leave
     empty if none — the default is that every entry above is advisory. -->
## Authoritative Overrides
