---
name: add-endpoint
description: Template skill for adding a new API endpoint the house way. This is a stack-neutral skeleton — copy it into .claude/skills/ during setup and customize every <!-- customize for your stack --> placeholder for your backend.
---

# add-endpoint (template)

> This is a **template**. Replace every `<!-- customize for your stack -->` with your
> project's real commands, paths, and conventions. Remove this note when done.

## When to use

Adding a new server endpoint (route + request/response contract + validation + tests).

## Steps

1. **Find the closest existing endpoint** and copy its shape.
   <!-- customize for your stack: name the reference file/module -->
2. **Define the request/response contract.**
   <!-- customize for your stack: schema/serializer location and style -->
3. **Add business validation** where business rules live (not in the shape layer).
   <!-- customize for your stack: validation layer + error response format -->
4. **Scope data access** to the requesting user unless deliberately public.
   <!-- customize for your stack: how querysets/records are scoped -->
5. **Translate all user-facing strings** (all supported languages).
   <!-- customize for your stack: i18n key convention + locale files -->
6. **Regenerate the client / contract** if the frontend consumes a generated client.
   <!-- customize for your stack: codegen command, requires server running -->
7. **Verify**: run linters + build, exercise the endpoint, confirm expected JSON.
   <!-- customize for your stack: exact lint/build/test commands -->

## Definition of done

- [ ] Endpoint appears in the API docs and returns expected data when exercised.
- [ ] Data access is user-scoped or justified as public.
- [ ] All new strings are translated in every supported language.
- [ ] Lint + build pass; the flow was actually run.
