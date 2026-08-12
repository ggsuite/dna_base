<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Index Guide

Every repo carries an **`index.md` in its root directory**. It is read
**by Claude to decide which repos must be added to a ticket** — when a
ticket is created, the agent scans the `index.md` files of the
available repos and picks the ones whose domain and interfaces match
the task (see the
[Project Management Guide](./project-management-guide.md)).

## Content

Three things, **as token-saving as possible**:

1. **Short summary** of the project — what this repo does.
2. **Domain / Goal** — which problem space it owns.
3. **Interfaces to other repos** — what it depends on, what depends on
   it, and through which API the coupling happens.

## Template

```markdown
# <pkg>

<1–2 sentences: what this repo does.>

## Domain / Goal

<Which problem space this repo owns. 1–3 bullets.>

## Interfaces

- uses `<repo-a>`: <for what / via which API>
- used by `<repo-b>`: <for what / via which API>
```

## Rules

- **Token economy first.** The file is read by an agent for every repo
  in the workspace during ticket planning — every superfluous sentence
  costs on each scan. No prose that repeats the README.
- **README is for humans, index.md is for agents.** Marketing-free
  either way, but index.md is radically compressed: keywords beat full
  sentences.
- **Interfaces are the payoff.** Whether a repo belongs to a ticket is
  mostly decided by its couplings — keep the interface list precise
  and current.
- **Update on change.** When the goal or the interfaces change, the
  same ticket updates `index.md`.
