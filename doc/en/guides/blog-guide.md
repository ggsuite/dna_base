<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Blog Guide

How to write blog posts in ggsuite repos. Blog posts document the
why and how of a change — the narrative companion to commits and
changelog entries.

## Location and naming

One file per post, per language and year:

```text
doc/en/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
doc/de/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
```

Example: `doc/en/blog/2026/2026-08-12-distribute-dna-via-npm.md`

Both languages, same file name — see the
[Multi-Language Guide](./multi-language-guide.md).

## Length

One to two screen pages — a digest, not a protocol. More is fine for
larger refactorings.

## Mandatory structure

```markdown
# <Title>

## Motivation

<Why, what for, for whom — the bigger goal, not just the trigger.>

## Strategy

<How the goal is reached. 3–7 bullet points.>

## Implementation 1, 2, …

<One focused section per implementation step / work package.>

## Open Points

<Not done yet, known limitations, deferred decisions.>
```

## Rules

- Always created when publishing: every publish gets a post covering
  the current ticket — see the [Publish Guide](./publish-guide.md).
- One post per ticket; the filename date is the publish date.
  Follow-up tickets get a new file, not a growing old one.
- Link posts from the README's Documentation section — see the
  [README Guide](./readme-guide.md).
