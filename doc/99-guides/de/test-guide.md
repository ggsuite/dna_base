<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Test-Guide

Wie in ggsuite-Projekten getestet wird. Tests sind Pflicht, keine
Empfehlung: `gg do commit` blockiert jeden Commit mit roten Tests oder
weniger als 100 % Coverage. Diese Regeln passen zu dieser Realität.

## Datei-Struktur

- `test/` spiegelt `lib/src/` 1:1:
  - `lib/src/foo.dart` → `test/foo_test.dart`
  - `lib/src/sub/bar.dart` → `test/sub/bar_test.dart`
- Eine Test-Datei pro Source-Datei — `gg can commit` warnt sonst.
- Test-Dateien beginnen mit dem Lizenz-Header, wie jede andere Datei.
- Top-Level-`main()`-Funktion, kein expliziter Rückgabetyp.

## Imports

```dart
import 'package:test/test.dart';                  // Dart packages
// or:
import 'package:flutter_test/flutter_test.dart';  // Flutter packages

import 'package:<pkg>/<pkg>.dart';                // own package via public API
```

`package:<pkg>/src/...` nur in Ausnahmefällen importieren — üblich,
wenn ein interner Helfer getestet werden muss, der absichtlich nicht
exportiert ist.

## Verschachtelung mit `group` / `test`

Drei-Ebenen-Hierarchie ist Default:

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

- **Äußere group** = Klassen- oder Top-Level-Funktions-Name.
- **Innere group** = Methoden-Signatur (`run()`, `logTask(...)`).
- **Test-Name** beginnt mit "should" oder beschreibt das beobachtete
  Verhalten.

## Setup, Teardown, Helfer

- `setUp` setzt gemeinsamen State zurück (Listen leeren,
  Test-Singletons zurücksetzen).
- `tearDown` räumt externe Ressourcen auf (temporäre Verzeichnisse,
  Fakes zurück auf `null`).
- Lokale Helper-Closures in `main()` für Setup-Logik, die mehrere
  Tests teilen — keine magischen Helper-Module, keine Vererbung.

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

## Kombinatorische Tests

Um dieselbe Logik mit mehreren Eingaben zu testen, `test(...)` in eine
einfache for-Schleife packen — keine parametrisierten
Test-Frameworks:

```dart
for (final cr in [null, false]) {
  test('with carriage return = $cr', () async { ... });
}
```

## Mocking-Politik

- **Echte Typen bevorzugen.** Konstruktoren bieten über optionale
  Parameter Dependency-Injection (`ggLog`, `promptUser`,
  `homeOverride`) — dann funktionieren Tests ohne Mocks.
- **Funktionen statt Mocks:** ein Callback
  (`String? Function(String)`) ist einfacher zu testen als eine
  gemockte `Stdin`-Klasse.
- **Test-Singletons:** globale Flags wie `isGitHub` haben einen
  `testIsGitHub`-Override; in `setUp` setzen, in `tearDown` auf
  `null` zurücksetzen.
- **`mockito`/`mocktail`:** nur wenn ohne Mock keine vernünftige
  Test-Strategie möglich ist (selten in den Referenz-Repos).

## Test-Inhalt

- Ein `test(...)` prüft **eine** Verhaltensweise. Mehrere `expect`s
  sind erlaubt, solange sie zusammen genau diese Verhaltensweise
  belegen.
- Strukturelle Vergleiche (`expect(messages, equals([...]))`) den
  Einzel-Asserts für Listen vorziehen.
- Exceptions:
  `expectLater(future, throwsA(isA<XyzError>().having((e) => e.message, 'message', contains('...'))))`.
- Future-Erfolg: `final result = await ...; expect(result, ...);`.
- **Kein `print` in Tests.** Wenn Output abgefangen werden muss,
  `capturePrint(...)` aus `gg_capture_print` benutzen.

## Coverage

- **100 % sind Pflicht.** `gg do commit` schlägt sonst fehl.
- Unerreichbare oder irrelevante Codepfade explizit markieren:

  ```dart
  // coverage:ignore-line
  // coverage:ignore-start
  ...
  // coverage:ignore-end
  ```

- Legitime Ignores sind z. B. eine `UnsupportedError`-Variante in
  einer Container-Implementierung oder Wrapper um nicht testbare
  `dart:io`-Aufrufe (`stdin.readLineSync()`-Fallbacks).
- **Ignores sind nicht zum Verstecken von Faulheit.** Wenn ein Pfad
  testbar ist — auch über Dependency-Injection — dann testen statt
  ignorieren.

## Stil-Konsistenz

- Sektions-Trenner auch in Tests:

  ```dart
  // #########################################################################
  group('subList(start, end)', () { ... });
  ```

- Test-Code ist Code: Lizenz-Header, Single Quotes, Trailing Commas,
  80-Zeichen-Zeilen (in Dart-Paketen).

## Lokale Validierung vor dem Commit

Vor jedem `gg do commit` läuft automatisch: `dart analyze` (sauber),
`dart format` (sauber), `dart test` (alle grün, 100 % Coverage).
Manuell mit `gg can commit` vorprüfen — nie mit roten Tests pushen.
