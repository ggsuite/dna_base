<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Blog Guide

How to write blog posts in dnaCompany repos. Blog posts document the
"why" and "how" of a change while it happens — they are the narrative
companion to commits and changelog entries.

## Location and naming

Blog posts live under `doc/blog/`, grouped by year, one file per post:

```text
doc/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
```

Example: `doc/blog/2026/2026-08-12-distribute-dna-via-npm.md`

## Length

**One to two screen pages.** Well summarized — a post is a digest, not
a protocol. For larger refactorings, more is fine.

## Mandatory structure

```markdown
# <Title of the blog post>

## Motivation

<Why, what for and for whom. The bigger goal.>

## Strategy

<How the goal will be reached. 3–7 bullet points.>

## Implementation 1

...

## Implementation 2

...

## Open Points

...
```

## Section by section

- **Motivation** — why, what for and for whom. Name the bigger goal
  the change serves, not just the immediate trigger.
- **Strategy** — how the goal is going to be reached, as **3–7 bullet
  points**. This is the plan at a glance.
- **Implementation 1, 2, …** — one section per implementation step or
  work package. Add as many as needed; keep each one focused.
- **Open Points** — what is not done yet, known limitations, decisions
  that were deferred.

## When posts are written

Blog posts are **always created when publishing** — every publish is
accompanied by a post covering the **current ticket**. Writing the
post is part of the publish routine, not an optional extra — see the
[Publish Guide](./publish-guide.md).

## Rules

- Reference blog posts from the README's Documentation section — see
  the [README Guide](./readme-guide.md).
- One post per ticket: the post summarizes what the ticket changed;
  the date in the filename is the publish date.
- Prefer several small posts over one ever-growing post: a follow-up
  ticket gets its own file with a new date.
