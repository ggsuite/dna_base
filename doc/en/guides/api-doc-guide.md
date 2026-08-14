<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# API Doc Guide

How to document ggsuite projects. Documentation is functional, not
"pretty": API understanding, reproducibility, traceability.

## File layout

- `// @license` header at the top of the file.
- `// ####…` (hashes up to column 80) before each top-level class.
- `// ….` (dots up to column 80) before every member, private ones
  too.
- Public API first, private members at the end behind a label block;
  subgroups: short dot line + label.

```dart
// #############################################################################
/// Represents a value of Type T in the memory.
class GgValue<T> {
  // ...........................................................................
  /// Sets the value and triggers an update on the stream.
  set value(T newVal) { /* … */ }

  // ######################
  // Private
  // ######################

  // .............
  // Stream

  // ...........................................................................
  T _value;
}
```

## Doc comments (`///`)

- Public members: yes; private: usually not. Order: separator line,
  `///`, declaration.
- Write docs on the interface or base class; `@override` members do
  not repeat them — Dart inherits doc comments.
- One sentence on one line, **at most 3 lines** (wrap at column 80);
  more than one only for caveats ("Important: …") and throws
  (`Throws a [StateError] when …`). Exception: `- [name]` parameter
  lists may be longer.
- English, 3rd-person indicative, what instead of how: "Returns …" —
  no "Will return", no imperative. Classes: one sentence.
- Reference other members with `[name]`; constructor parameters:

  ```dart
  /// - [seed] The initial seed of the value.
  /// - [name] is an optional identifier for the value.
  ```

## Inside bodies

- No explanatory inline comments; only pragmas
  (`// coverage:ignore-line`, `// ignore: …`).

## Do not document

- Trivialities: a getter `length` needs no explanation — if the lint
  requires a doc comment, the plain variant is enough.
- How the code does it — doc comments explain _what_ and _why_.
- Personal notes, "maybe later" plans, FIXMEs.
