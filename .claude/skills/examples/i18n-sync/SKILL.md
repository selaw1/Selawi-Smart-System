---
name: i18n-sync
description: Template skill for keeping translation catalogs in sync across all supported languages. This is a stack-neutral skeleton — copy it into .claude/skills/ during setup and customize every <!-- customize for your stack --> placeholder for your i18n setup.
---

# i18n-sync (template)

> This is a **template**. Replace every `<!-- customize for your stack -->` with your
> project's real commands, paths, and conventions. Remove this note when done.

## When to use

After adding or changing user-facing strings, to guarantee every supported language has an
entry and no key is missing or orphaned.

## Steps

1. **Locate the locale files** for every supported language.
   <!-- customize for your stack: locale file paths, one per language -->
2. **Extract new keys** from the code changes.
   <!-- customize for your stack: extraction command, if any -->
3. **Add each new key to every language file** with a real translation (no English
   placeholders left in non-default languages).
   <!-- customize for your stack: key naming convention -->
4. **Detect missing / orphaned keys** across languages and reconcile them.
   <!-- customize for your stack: diff/compile command that flags gaps -->
5. **Compile / build the catalogs** and confirm no errors.
   <!-- customize for your stack: compile command -->

## Definition of done

- [ ] Every supported language has an entry for every key — verified, not assumed.
- [ ] No missing or orphaned keys remain.
- [ ] Catalog compile/build succeeds.
