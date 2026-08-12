<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Example Guide

How to ship examples with dnaCompany packages. Every package has an
`example/` folder that demonstrates the happy path.

## Dart packages

- One file: `example/<pkg>_example.dart`.
- Runnable via `dart run example/<pkg>_example.dart`.
- Optional shebang: `#!/usr/bin/env dart`.

## Flutter packages

- `example/` is a complete Flutter sub-project:
  - `example/lib/main.dart`
  - `example/pubspec.yaml`
  - `example/test/`

## Rules

- **License header** also in examples — an example file is a normal
  source file.
- **Functionally complete:** the example shows the happy path
  including setup. No "TODO: implement".
- The example imports the package through its **public API**
  (`package:<pkg>/<pkg>.dart`), never through `src/`.
- Keep the example minimal: one file that a reader can run and
  understand in a few minutes beats a second demo app.
- The README usage snippet and the example should not drift apart —
  when the API changes, update both.
