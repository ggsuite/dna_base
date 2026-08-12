<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# File Structure Guide

Every repo documents its project structure in **`doc/file-structure.md`**.
This file is maintained **by Claude, continuously, while programming**:
whenever a change adds, moves, renames or removes files or folders,
`doc/file-structure.md` is updated in the same change.

## Why a doc file and not CLAUDE.md?

This information would normally live in `CLAUDE.md`. Keeping it in
`doc/file-structure.md` instead has two advantages:

- Humans read it as part of the normal documentation, not as agent
  configuration.
- `CLAUDE.md` stays small and simply references the file, so the agent
  still loads it.

## Format

An annotated tree: one entry per file or folder that matters, with a
short comment on its purpose.

````markdown
# File Structure

```text
lib/
  <pkg>.dart          # public API (barrel file)
  src/
    foo.dart          # <what foo does>
test/
  foo_test.dart       # mirrors lib/src/foo.dart
doc/
  blog/               # blog posts, one folder per year
  file-structure.md   # this file
example/
  <pkg>_example.dart  # runnable usage example
```
````

## Rules

- **Always up to date.** The structure file changes in the same commit
  as the structural change — never as a follow-up.
- **Purpose over inventory.** Each entry carries a short comment about
  what the file or folder is for. Trivial or generated entries
  (`node_modules/`, build output) are left out.
- **The repo is the truth.** When the file and reality disagree, fix
  the file — as part of the change that notices the mismatch.
- **Reference, don't duplicate.** `CLAUDE.md` links to
  `doc/file-structure.md`; the structure is not maintained in two
  places.
