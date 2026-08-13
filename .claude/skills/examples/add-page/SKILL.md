---
name: add-page
description: Template skill for adding a new frontend page/screen the house way. This is a stack-neutral skeleton — copy it into .claude/skills/ during setup and customize every <!-- customize for your stack --> placeholder for your frontend.
---

# add-page (template)

> This is a **template**. Replace every `<!-- customize for your stack -->` with your
> project's real commands, paths, and conventions. Remove this note when done.

## When to use

Adding a new user-facing page/screen (route + data fetching + UI + states).

## Steps

1. **Find the closest existing page** and copy its shape.
   <!-- customize for your stack: name the reference page/component -->
2. **Register the route** using the project's route config, never a hardcoded string.
   <!-- customize for your stack: route config location -->
3. **Wire data reads/writes** through the project's data layer.
   <!-- customize for your stack: query/mutation hooks or store; no raw fetch -->
4. **Handle loading / empty / error states.**
   <!-- customize for your stack: suspense/boundary conventions -->
5. **Translate all UI strings** and support layout direction if applicable.
   <!-- customize for your stack: i18n keys + RTL/LTR handling -->
6. **Refresh any context-shaping data** after mutations that change it.
   <!-- customize for your stack: context refresh call -->
7. **Verify** in the running app (light/dark, both directions if layout changed).
   <!-- customize for your stack: exact lint/build/dev commands -->

## Definition of done

- [ ] Lint + build pass; the flow was driven in the running app.
- [ ] No hardcoded route strings, no untranslated strings, no raw data calls.
- [ ] Renders correctly in every theme and layout direction the project supports.
