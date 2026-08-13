<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Develop Guide

How to use `gg` for daily development at ggsuite. Git operations
run **always through `gg`** (v15+), never through raw `git commit` /
`git push`. `gg` runs the checks before every commit (analyze, format,
tests, 100 % coverage), maintains the changelog and enforces the
branch guard — raw git bypasses all of that.

> **Deprecated:** `kd` no longer exists. All old `kd do …` commands
> are replaced by `gg …`; `gg multi` is only a hidden alias for the
> root commands.

## Two modes: `gg` (workspace) and `gg one`

`gg` detects where it runs:

- **Ticket workspace** — a directory tree with `.ocean/` (legacy name
  `.master/` is renamed automatically) or `tickets/`: `gg <cmd>` runs
  as `gg_multi` over **all repos of the ticket in dependency order**.
- **Standalone project** (`pubspec.yaml`, `package.json` or
  `tsconfig.json`): use `gg one <cmd>` explicitly. A bare
  `gg do commit` does nothing there and points you to `gg one`.
- `gg one` also works **inside** a ticket workspace when a command
  should target a single repo only.

## Branches and tickets

- **Never commit on `main`/`master`.** `gg do commit` refuses with an
  error. `--force` is the documented escape hatch — only with explicit
  human approval.
- **Branch name = ticket ID.** `gg do add <repo>` checks out the
  branch named after the ticket in every added repo.
- Ticket IDs are short and speaking, in the style of the existing
  tickets (e.g. `gGS-123` or `fix_login_crash`).
- See the [Project Management Guide](./project-management-guide.md)
  for creating tickets and adding repos.

## The daily loop

```bash
cd tickets/<ticket-id>   # or the standalone repo
gg do code               # open the VS Code workspace
# ... implement ...
gg can commit            # check without side effects
gg do commit -m 'Add dashboard export'
gg can push
gg do push
```

For standalone repos prefix everything with `one`:
`gg one can commit`, `gg one do commit -m '...'`, `gg one do push`.

- **`can` before `do`:** `gg can commit` checks without side effects
  (analyze + format + tests + coverage). `gg do commit` runs the
  checks anyway and aborts on red — never bypass red checks with
  `--force`.
- **`gg do push`** first merges `main` into the feature branch, then
  pushes; in a workspace for all ticket repos in dependency order.
  Open pull requests get updated automatically.
- Commits are small and logically scoped — one unit of change per
  `gg do commit`, no batch commits across unrelated topics.

## Commit messages

- **English, imperative, one concise sentence** ("Add dashboard
  export", "Fix race condition in dispose").
- `gg do commit -m` writes the message **automatically into the
  CHANGELOG** (Dart projects). The changelog section is derived from
  the message:

  | Message …             | CHANGELOG section |
  | --------------------- | ----------------- |
  | starts with `add`     | Added             |
  | contains `change`     | Changed           |
  | contains `deprecate`  | Deprecated        |
  | contains `fix`        | Fixed             |
  | contains `remove`     | Removed           |
  | contains `secure`     | Security          |
  | otherwise             | Changed           |

  Phrase messages so the mapping applies — a bug fix starts with
  "Fix …", a new feature with "Add …".
- `--no-log` only when a commit deliberately gets no changelog entry
  (rare).
- **No Co-Authored-By trailers** and no other auto-trailers.

## State queries

`gg did commit`, `gg did push`, `gg did review` report whether the
current state is committed / pushed / reviewed. Use these commands
instead of interpreting `git log` / `git status` by hand.

## Review and publish

- Reviews run through `gg do review` — see the
  [Review Guide](./review-guide.md).
- Publishing runs through `gg do publish` and is **human-only** — see
  the [Publish Guide](./publish-guide.md).

## What raw git is still allowed to do

Only **reading** operations: `git status`, `git log`, `git diff`,
`git show`, `git blame`. Plus `git pull` on `main` before creating a
ticket. Everything writing (commit, push, merge, rebase, tag) goes
through `gg`.

## What not to do

- **No** manual `git commit` / `git push` / `git merge`.
- **No** commits on `main`/`master`; `--force` is never the norm.
- **No** bypassing red checks (`--force`, test skips, coverage
  ignores) — fix first, then commit.
- **No** `gg do publish` triggered by agents.
- **No** `kd` commands — docs or scripts mentioning `kd` are outdated
  and should be reported.
