<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# README Guide

How to write a README for ggsuite packages. Tone: concise,
technical, English. No marketing sentences.

## Mandatory structure

In this order:

````markdown
# <PackageName>

<1–3 sentences: What does this package do? Which problem does it solve?>

## Goals

- <What is the goal of this repo?>
- <3–7 bullet points>

## Installation

<How do I get the project running? Execution. Integration.>

## Documentation

- <Link to the blog>
- <Link to the architecture docs>
- <Links to the guides>

## Code Examples

<The most important features — not all of them>

```dart
import 'package:<pkg>/<pkg>.dart';

void main() async {
  // Minimal example that runs without modification
}
```

## Contributing

<Notes on how to contribute to this repo>

## Open Bugs

- <All open bugs are listed here>
````

## Section by section

- **Goals** — what this repo wants to achieve, as **3–7 bullet
  points**. No prose essays; each bullet is one goal.
- **Installation** — everything needed to get the project running:
  how to install it, how to execute it, and how to integrate it into
  another project (dependency setup).
- **Documentation** — pointers, not content: link the blog, the
  architecture documentation and the guides (`doc/99-guides/`). The
  README stays the entry point, details live behind the links.
- **Code Examples** — show the **most important features, not all**.
  Every snippet must be runnable without modification — no pseudo
  code, no `// TODO`. Keep the snippets in sync with `example/` (see
  the [Example Guide](./example-guide.md)).
- **Contributing** — how to work on this repo: ticket workflow,
  commit/review rules. Link the
  [Develop Guide](./develop-guide.md) and
  [Review Guide](./review-guide.md) instead of repeating them.
- **Open Bugs** — **all** open bugs are listed here, each as one
  bullet, ideally linked to its issue.

## Optional and common additions

- **`## State`** with a CI badge:

  ```markdown
  [![Dart Script Execution](https://github.com/ggsuite/<pkg>/actions/workflows/check.yaml/badge.svg)](...)
  ```

- **`## Classes`** as a table for multi-class packages:

  ```markdown
  | Class    | Description                          |
  | :------- | :----------------------------------- |
  | `GgList` | Create lists of ordinary value types |
  ```

- **`## How It Works`** for non-trivial mechanics.
- **Table of contents** for long READMEs (maintained manually).

## Rules

- The intro answers "what & why" in at most three sentences; details
  belong in the sections below or in the API docs.
- Keep the README in sync with behavior changes — a changed public API
  without a README update is a review finding.
- The "Open Bugs" list is maintenance-critical: a fixed bug leaves the
  list in the same commit that fixes it.
- The README exists in English (`README.md`) and German
  (`README.de.md`) — both are updated in the same change; see the
  [Multi-Language Guide](./multi-language-guide.md).
