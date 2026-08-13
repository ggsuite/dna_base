<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Architecture Guide

How ggsuite packages are structured. These rules were extracted
from the reference repos (`gg_status_printer`, `gg_typedefs`,
`gg_router`, `gg_list`) and apply to every package.

## Package layout

- **Package name = repo name = class prefix.** `gg_status_printer`
  exports `GgStatusPrinter`. Never two top-level concepts in one
  package — split instead.
- **The public API lives in `lib/<package>.dart`** and is a pure
  barrel file: license header, `library;`, then only
  `export 'src/...';` lines. No implementation.
- **Implementation lives in `lib/src/<file>.dart`.** External
  consumers never import `package:<pkg>/src/...`.
- **File names are snake_case** and mirror the main type inside
  (`gg_status_printer.dart` contains `class GgStatusPrinter`). Closely
  related small helpers (enums, typedefs, short data classes) may live
  in the same file.
- **Tests mirror `lib/src/` 1:1** — see the
  [Test Guide](./test-guide.md).

## Class structure

Member order inside a class:

1. **Constructor(s)** first, with `///` docs.
2. **Factory constructors** next (`Foo.generate(...)`,
   `Foo.fromList(...)`).
3. **Public methods**, ordered by logical relatedness, not
   alphabetically.
4. **Public fields / getters** (all `final`).
5. **Static constants and methods.**
6. **Private fields & methods** at the end, `_`-prefixed.

Fields are `final` by default. Mutability is avoided; "changing" goes
through copy-with methods (`copyWithValue`, `transform`).

## API design

- **Named parameters with `required`** are the default. Positional
  parameters only for trivial one-argument constructors.
- Sensible defaults in the constructor (`ggLog = print`,
  `useCarriageReturn = !isGitHub`) — that is what makes dependency
  injection and mock-free tests possible.
- **Generic type parameters** where reusable containers or workflows
  are involved (`GgStatusPrinter<T>`, `GgList<T>`).
- **Factory constructors** for alternative construction (`.generate`,
  `.fromList`).
- Async code returns `Future<T>`; errors are handled with
  `try / catch / rethrow` — never swallowed.
- All futures are awaited or explicitly marked with `unawaited(...)`
  (lint `unawaited_futures` is active).

## Section comments (visual landmarks)

These markers are a codebase-wide convention — they help scanning and
are not doc comments. Do not omit them and do not invent variants:

- `// ###########################################################` —
  before classes, enums and other top-level constructs.
- `// ...........................................................` —
  before every method, getter or field block that carries a doc
  comment.
- Named section blocks inside large classes:

  ```dart
  // ######################
  // Private
  // ######################
  ```

## Linting

`analysis_options.yaml` includes `package:lints/recommended.yaml` plus
the mandatory rule set (single quotes, trailing commas, relative
imports, 80-character lines, declared return types,
`public_member_api_docs`, `unawaited_futures`, const-preferences) and
strict analyzer modes (`strict-casts`, `strict-inference`,
`strict-raw-types`). Flutter packages may disable
`lines_longer_than_80_chars` and the `strict-*` modes **when
necessary** — but only there.

## Naming quick reference

| Construct      | Style                              | Example                     |
| -------------- | ---------------------------------- | --------------------------- |
| Class          | `Gg<X>` PascalCase                 | `GgRouterDelegate`          |
| File           | snake_case with `gg_` prefix       | `gg_router_delegate.dart`   |
| Test file      | `<filename>_test.dart`             | `gg_router_delegate_test.dart` |
| Private member | `_camelCase`                       | `_updateState`              |
| Constant       | `lowerCamelCase` (no SCREAMING)    | `carriageReturn`            |
| Enum value     | `lowerCamelCase`                   | `GgStatusPrinterStatus.success` |

## What not to do

- **No** `dynamic` return types (`always_declare_return_types` is an
  error).
- **No** double quotes (`prefer_single_quotes`).
- **No** mutation of public fields; setters only with a clear reason.
- **No** TODO comments without an issue/ticket reference.
- **No** commented-out code blocks "for later" — git is the history.
