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
- Check upfront with `gg can publish`.

## What publish does

```bash
gg do publish
```

`gg` triggers the pull request merge, publishes the changes to the
registry, and finally adds and pushes the version tag.

## Non-interactive publish (CI)

```bash
gg do publish --config .gg-publish.json
```

The config contains:

- `version_increment` — `patch` | `minor` | `major`
- `merge_message`
- optional per-repo overrides

Missing required fields abort the run — there is no silent prompt
fallback.

## Before publishing

- **A blog post for the current ticket is created** — blog posts are
  always written as part of publishing, under
  `doc/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md`. See the
  [Blog Guide](./blog-guide.md).
- `CHANGELOG.md` reflects the release (maintained automatically by
  `gg do commit`, see the [Doc Guide](./doc-guide.md)).
- README and example match the published API — see the
  [README Guide](./readme-guide.md) and
  [Example Guide](./example-guide.md).
- For pub.dev packages: enable the `pana` check in
  `.github/workflows/check.yaml` before publishing.
