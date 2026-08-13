# secrets/

This folder holds project secrets: API keys, signing certificates, service-account
files, `.env` values, and anything else that must never be public.

## Rules

- **Everything in `secrets/` is gitignored.** See `secrets/.gitignore` — it ignores
  everything except `.gitignore` and this `README.example.md`.
- **Never `git add` a real secret.** Not even "temporarily". If a secret is committed,
  treat it as compromised and rotate it.
- **This file (`README.example.md`) is the only tracked content here besides
  `.gitignore`.** It documents what belongs here; it never contains actual secrets.

## What belongs here

- API keys / tokens for third-party services
- Signing certificates and provisioning profiles (e.g. `apple/key.p8`)
- Private `.env` files with credentials
- Any per-environment secret material

## How code reads these

<!-- prompt: describe how the app loads secrets at runtime (env vars, a secrets manager,
     mounted files) — filled during /project-setup. Do NOT hardcode secret values. -->
