<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Index Guide

Every repo has an `index.md` in its root. Claude reads it during
ticket planning to decide which repos a ticket needs.

## Template

```markdown
# <pkg>

<1–2 sentences: what this repo does.>

## Domain / Goal

<1–3 bullets: which problem space this repo owns.>

## Interfaces

- uses `<repo-a>`: <for what / via which API>
- used by `<repo-b>`: <for what / via which API>
```

## Rules

- As token-saving as possible: keywords beat sentences; no prose that
  repeats the README.
- Interfaces decide ticket membership — keep them precise and current.
- When goal or interfaces change, the same ticket updates `index.md`.
