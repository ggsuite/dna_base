<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Documentation Guide

How to document ggsuite projects. Documentation is **functional**,
not "pretty": every piece has a clear goal — API understanding,
reproducibility, traceability of changes.

## Doc comments in code (`///`)

- Every public member has a `///` doc comment (lint
  `public_member_api_docs` is active).
- **What, not how.** "Returns the list value at index `[i]`" — not
  "Loops through internal data and returns the i-th".
- **Consistent tense:** 3rd-person indicative ("Updates the state.",
  "Throws when ..."), no "Will update", no imperative "Update the
  state.".
- **Parameter docs as a list** using the `- [name]` syntax:

  ```dart
  /// Run the operation and display the status.
  ///
  /// - [task] to be executed.
  ///   - If the task throws, an error state will be printed.
  ///   - If the task completes successfully, a success state will be printed.
  ```

- **Examples** in doc comments only when the call does not follow
  obviously from signature + description — then as a ` ```dart `
  block.
- **Throw behavior** is made explicit when relevant:
  `Throws a [StateError] when ...`.

## README.md

See the [README Guide](./readme-guide.md) for the mandatory structure.

## CHANGELOG.md

[Keep a Changelog](https://keepachangelog.com) style:

```markdown
# Changelog

## [1.2.0] - 2026-04-29

### Added
- New `Foo.bar` factory.

### Changed
- Default of `useCarriageReturn` is now `!isGitHub`.

### Fixed
- Race condition in `dispose`.

## [1.1.5] - 2026-04-12
...

[1.2.0]: https://github.com/ggsuite/<pkg>/compare/1.1.5...1.2.0
[1.1.5]: https://github.com/ggsuite/<pkg>/compare/1.1.4...1.1.5
```

Rules:

- **Reverse chronological** — newest on top.
- **Sections** only when relevant: `Added`, `Changed`, `Fixed`,
  `Removed` (sometimes `Deprecated`, `Security`).
- **Version header:** `## [<semver>] - <YYYY-MM-DD>`; square brackets
  for linked versions, compare links at the end of the file.
- **Bullet items** are short and imperative ("Add X", "Fix Y").
- `gg do commit -m "..."` writes the commit message into the changelog
  automatically. Manual edits are allowed but should rarely be needed.

## example/

See the [Example Guide](./example-guide.md).

## doc/file-structure.md

The project structure of the repo, maintained continuously by Claude
while programming. See the
[File Structure Guide](./file-structure-guide.md).

## Workflow files (.github/workflows/)

- `pipeline.yaml` — the standard pipeline created by
  `gg_create_package`. Triggered on `push` to `main`; runs checkout,
  SDK setup, `pub get`, `dart pub global activate gg` and the `gg`
  checks. **Do not modify on your own** — pipeline changes go through
  the `gg` tooling or team agreement.
- `check.yaml` — the local `gg` check switches:

  ```yaml
  needsInternet: false
  analyze:
    execute: true
  format:
    execute: true
  tests:
    execute: true
  pana:
    execute: false # true for Flutter packages or before publishing
  ```

## CLAUDE.md

The `CLAUDE.md` in the repo root is loaded automatically by Claude
Code. It contains:

- **The managed block**, maintained by Helix between
  `<!-- helix:claude_md:start -->` and `<!-- helix:claude_md:end -->`:
  one `@`-import line per file listed in `claude.claudeMdInclude` of
  `dna/_dna.json` (folders expand to their `.md` files). Listing
  `doc/99-guides/en` makes all guides mandatory reading at every
  session start — see the [DNA Design Guide](./dna-design-guide.md).
- **Repo-specific notes** outside the managed block: architecture
  sketch, domain terms, project-specific workflows.

Not in CLAUDE.md: onboarding prose, marketing, anything that belongs
in the README or in code docs.

## What not to document

- **Trivialities:** a getter `length` needs no doc comment explaining
  "Returns the length" — if the lint requires one, the plain variant
  is enough.
- **"How the code does it":** that is what the code says. Doc comments
  explain *what* and *why*, not *how*.
- **Personal notes,** "maybe later" plans, "FIXME: I don't understand
  this" — none of these belong in the repo.
