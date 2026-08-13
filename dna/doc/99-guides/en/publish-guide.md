<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Publish Guide

How to publish dnaCompany packages. Publishing runs through `gg` and
is deliberately the most guarded step in the workflow.

## Ground rules

- **`gg do publish` is triggered by a human only** — never by an
  agent, not even "helpfully" after a green review.
- Publish refuses when the current ticket state has not been reviewed
  (`gg did review`). Commits after the last review require a new
  `gg do review` — see the [Review Guide](./review-guide.md).
- Check upfront with `gg can publish` (runs `pana` by default;
  `--no-pana` skips it).

## What publish does

```bash
gg do publish            # ticket workspace: all repos in dependency order
gg one do publish        # standalone repo
```

For each repo: bump the version (per the configured increment), merge
via an **auto-merge pull request** (default; `--no-pr` merges locally
and pushes directly), publish to the registry (pub.dev and/or npm —
hybrid packages go to both), add and push the version tag, and delete
the remote feature branch (default).

Useful flags (from `gg do publish -h` — the help is the truth):

- `--merge-only` — merge the ticket without releasing (no version
  bump, no tag); `--force` allows it despite local refs.
- `--continue` — resume a failed publish where it stopped.
- `--restart` — discard the saved run state and configure again
  (`--continue` cannot be combined with `--config` or `--restart`).
- `--publish-unchanged` — publish every repo, even unchanged ones.
- `--channel stable|rc` (single repo) — `rc` publishes the next
  `X.Y.Z-rc.N` prerelease instead of a stable release.

## The publish config (`.gg/`)

Two files per repo, deliberately separated:

- **`.gg/publish_config.json`** — the **inputs**, camelCase, wrapped
  in a `publishConfig` root key. **This is the file the AI maintains
  while it works:**
  - `mergeMessage` — pull-request title and merge commit message,
    initialized from the ticket description.
  - `versionIncrement` — `patch` | `minor` | `major`.
  - `nextCommitMessage` — the proposal the next `gg do commit` shows;
    the AI keeps it in sync with whatever is currently uncommitted.
  - `commits` — the messages of the commits this ticket already made,
    written by `gg do commit` (never by hand); rendered as the
    pull-request description.
- **`.gg/publish_state.json`** — the **run progress** (status, done
  steps, branch, channel, …). Written by `gg do publish` while it
  runs; `--continue` resumes from it, `--restart` discards it. Never
  edit it by hand.

## Legacy: `.gg-publish.json`

The old single config file (snake_case: `version_increment`,
`merge_message`, `channel`, `delete_ticket`, `delete_feature_branch`,
`pr`, plus per-repo overrides under `repos.<name>`) is **read-only
legacy**: `--config path/to/.gg-publish.json` still accepts it for
headless runs, and a leftover file keeps an in-flight ticket
resumable — but gg never writes this format again. Missing required
fields abort the run; there is no silent prompt fallback.

## Before publishing

- **A blog post for the current ticket is created** — blog posts are
  always written as part of publishing, in both languages under
  `doc/blog/<en|de>/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md`. See the
  [Blog Guide](./blog-guide.md).
- `CHANGELOG.md` reflects the release (maintained automatically by
  `gg do commit`, see the [Doc Guide](./doc-guide.md)).
- README and example match the published API — see the
  [README Guide](./readme-guide.md) and
  [Example Guide](./example-guide.md).
- For pub.dev packages: `pana` runs as part of `gg can publish` by
  default — keep it green.
