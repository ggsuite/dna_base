<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# README Guide

How to write a README for dnaCompany packages. Concise, technical,
English; no marketing.

## Mandatory structure

In this order:

````markdown
# <PackageName>

<1–3 sentences: what does this package do, which problem does it solve?>

## Goals

- <3–7 bullets; each bullet is one goal, no prose essays>

## Installation

<Everything to get it running: install, execute, integrate as
dependency.>

## Documentation

- <Pointers, not content: link the blog, the architecture docs and
  the guides (`doc/en/guides/`)>

## Code Examples

<The most important features, not all. Every snippet runnable without
modification — no pseudo code, no TODOs; kept in sync with `example/`
(see the [Example Guide](./example-guide.md)).>

```dart
import 'package:<pkg>/<pkg>.dart';

void main() async {
  // Minimal example that runs without modification
}
```

## Contributing

<Ticket workflow, commit/review rules — link the
[Develop Guide](./develop-guide.md) and
[Review Guide](./review-guide.md) instead of repeating them.>

## Open Bugs

- <ALL open bugs, one bullet each, ideally linked to their issue>
````

## Optional additions

- `## State` with a CI badge:

  ```markdown
  [![Dart Script Execution](dnaGitOrgUrl/<pkg>/actions/workflows/check.yaml/badge.svg)](...)
  ```

- `## Classes` as a table for multi-class packages.
- `## How It Works` for non-trivial mechanics.
- Table of contents for long READMEs (maintained manually).

## Rules

- The intro answers "what & why" in at most three sentences; details
  live in the sections below or in the API docs.
- A changed public API without a README update is a review finding.
- A fixed bug leaves "Open Bugs" in the same commit that fixes it.
- `README.md` (en) and `README.de.md` (de) are updated in the same
  change — see the [Multi-Language Guide](./multi-language-guide.md).
