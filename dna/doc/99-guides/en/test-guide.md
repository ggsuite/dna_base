<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Test Guide

How to test in dnaCompany projects. Tests are mandatory, not a
recommendation: `gg do commit` blocks every commit with failing tests
or less than 100 % coverage. These rules match that reality.

## File structure

- `test/` mirrors `lib/src/` 1:1:
  - `lib/src/foo.dart` → `test/foo_test.dart`
  - `lib/src/sub/bar.dart` → `test/sub/bar_test.dart`
- One test file per source file — `gg can commit` warns otherwise.
- Test files start with the license header, like every other file.
- Top-level `main()` function, no explicit return type.

## Imports

```dart
import 'package:test/test.dart';                  // Dart packages
// or:
import 'package:flutter_test/flutter_test.dart';  // Flutter packages

import 'package:<pkg>/<pkg>.dart';                // own package via public API
```

Import `package:<pkg>/src/...` only in exceptional cases — usually to
test an internal helper that is intentionally not exported.

## Nesting with `group` / `test`

A three-level hierarchy is the default:

```dart
void main() {
  group('GgStatusPrinter', () {           // class name
    group('run()', () {                   // method incl. (args)
      group('Should print running and', () {
        test('success messages', () { ... });
        test('error messages', () { ... });
      });
    });
    group('logTask(...)', () {
      test('with success should print success status', () { ... });
    });
  });
}
```

- **Outer group** = class or top-level function name.
- **Inner group** = method signature (`run()`, `logTask(...)`).
- **Test name** starts with "should" or describes the observed behavior.

## Setup, teardown, helpers

- `setUp` resets shared state (clear lists, reset test singletons).
- `tearDown` cleans up external resources (temp directories, fakes
  back to `null`).
- Use local helper closures inside `main()` for setup logic shared by
  several tests — no magic helper modules, no inheritance.

```dart
void main() {
  late Directory tmp;
  final messages = <String>[];

  setUp(() {
    tmp = Directory.systemTemp.createTempSync('foo_test_');
    messages.clear();
  });

  tearDown(() => tmp.deleteSync(recursive: true));

  Directory makeFixture(String name) =>
      Directory(p.join(tmp.path, name))..createSync();

  group('Foo', () { ... });
}
```

## Combinatorial tests

To run the same logic with several inputs, wrap `test(...)` in a plain
for-loop — no parameterized test frameworks:

```dart
for (final cr in [null, false]) {
  test('with carriage return = $cr', () async { ... });
}
```

## Mocking policy

- **Prefer real types.** Constructors offer dependency injection via
  optional parameters (`ggLog`, `promptUser`, `homeOverride`) — then
  tests work without mocks.
- **Functions instead of mocks:** a callback
  (`String? Function(String)`) is easier to test than a mocked
  `Stdin` class.
- **Test singletons:** global flags like `isGitHub` have a
  `testIsGitHub` override; set it in `setUp` and reset it to `null` in
  `tearDown`.
- **`mockito`/`mocktail`:** only when no reasonable test strategy
  exists without a mock (rare in the reference repos).

## Test content

- One `test(...)` verifies **one** behavior. Several `expect`s are
  fine as long as together they prove exactly that behavior.
- Prefer structural comparisons (`expect(messages, equals([...]))`)
  over per-element asserts for lists.
- Exceptions:
  `expectLater(future, throwsA(isA<XyzError>().having((e) => e.message, 'message', contains('...'))))`.
- Future success: `final result = await ...; expect(result, ...);`.
- **No `print` in tests.** If output must be captured, use
  `capturePrint(...)` from `gg_capture_print`.

## Coverage

- **100 % is required.** `gg do commit` fails otherwise.
- Mark unreachable or irrelevant code paths explicitly:

  ```dart
  // coverage:ignore-line
  // coverage:ignore-start
  ...
  // coverage:ignore-end
  ```

- Legitimate ignores are e.g. an `UnsupportedError` variant in a
  container implementation or wrappers around untestable `dart:io`
  calls (`stdin.readLineSync()` fallbacks).
- **Ignores are not for hiding laziness.** If a path is testable —
  also via dependency injection — test it instead of ignoring it.

## Style consistency

- Use section separators in tests too:

  ```dart
  // #########################################################################
  group('subList(start, end)', () { ... });
  ```

- Test code is code: license header, single quotes, trailing commas,
  80-character lines (in Dart packages).

## Local validation before commit

Before every `gg do commit` the following runs automatically:
`dart analyze` (clean), `dart format` (clean), `dart test` (all green,
100 % coverage). Check manually with `gg can commit` — never try to
push with red tests.
