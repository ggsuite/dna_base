<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Architecture-Guide

Wie dnaCompany-Pakete strukturiert sind. Diese Regeln wurden aus den
Referenz-Repos (`gg_status_printer`, `gg_typedefs`, `gg_router`,
`gg_list`) extrahiert und gelten für jedes Paket.

## Paket-Layout

- **Paketname = Repo-Name = Klassen-Prefix.** `gg_status_printer`
  exportiert `GgStatusPrinter`. Nie zwei Top-Level-Konzepte in einem
  Paket — stattdessen aufteilen.
- **Die Public API liegt in `lib/<package>.dart`** und ist eine reine
  Barrel-Datei: Lizenz-Header, `library;`, dann ausschließlich
  `export 'src/...';`-Zeilen. Keine Implementierung.
- **Die Implementierung liegt in `lib/src/<file>.dart`.** Externe
  Konsumenten importieren nie `package:<pkg>/src/...`.
- **Dateinamen sind snake_case** und spiegeln den Haupt-Typ darin
  (`gg_status_printer.dart` enthält `class GgStatusPrinter`). Eng
  verwandte kleine Helfer (Enums, Typedefs, kurze Datenklassen)
  dürfen mit in derselben Datei liegen.
- **Tests spiegeln `lib/src/` 1:1** — siehe
  [Test-Guide](./test-guide.md).

## Klassen-Aufbau

Reihenfolge der Mitglieder in einer Klasse:

1. **Konstruktor(en)** zuerst, mit `///`-Doku.
2. **Factory-Konstruktoren** danach (`Foo.generate(...)`,
   `Foo.fromList(...)`).
3. **Public Methods**, geordnet nach logischer Verwandtschaft, nicht
   alphabetisch.
4. **Public Felder / Getter** (alle `final`).
5. **Statische Konstanten und Methoden.**
6. **Private Felder & Methoden** am Ende, mit `_`-Prefix.

Felder sind grundsätzlich `final`. Mutability wird vermieden;
"Ändern" läuft über Copy-with-Methoden (`copyWithValue`,
`transform`).

## API-Design

- **Named Parameters mit `required`** sind der Default. Positionale
  Parameter nur bei trivialen Ein-Argument-Konstruktoren.
- Sinnvolle Defaults im Konstruktor (`ggLog = print`,
  `useCarriageReturn = !isGitHub`) — genau das ermöglicht
  Dependency-Injection und Tests ohne Mocks.
- **Generische Typ-Parameter**, wo es um wiederverwendbare Container
  oder Workflows geht (`GgStatusPrinter<T>`, `GgList<T>`).
- **Factory-Konstruktoren** für alternative Erzeugung (`.generate`,
  `.fromList`).
- Async-Code gibt `Future<T>` zurück; Fehler werden mit
  `try / catch / rethrow` behandelt — nie geschluckt.
- Alle Futures werden awaited oder explizit mit `unawaited(...)`
  markiert (Lint `unawaited_futures` ist aktiv).

## Sektions-Kommentare (visuelle Landmarken)

Diese Marker sind Konvention im ganzen Codebase — sie helfen beim
Scannen und sind keine Doc-Comments. Nicht weglassen und keine
eigenen Varianten erfinden:

- `// ###########################################################` —
  vor Klassen, Enums und anderen Top-Level-Konstrukten.
- `// ...........................................................` —
  vor jeder Methode, jedem Getter, jedem Feld-Block mit Doc-Comment.
- Benannte Sektions-Blöcke in großen Klassen:

  ```dart
  // ######################
  // Private
  // ######################
  ```

## Linting

`analysis_options.yaml` enthält `package:lints/recommended.yaml` plus
das Pflicht-Regelset (Single Quotes, Trailing Commas, relative
Imports, 80-Zeichen-Zeilen, deklarierte Rückgabetypen,
`public_member_api_docs`, `unawaited_futures`, Const-Präferenzen) und
die strikten Analyzer-Modi (`strict-casts`, `strict-inference`,
`strict-raw-types`). Flutter-Pakete dürfen
`lines_longer_than_80_chars` und die `strict-*`-Modi deaktivieren —
**wenn nötig**, und nur dort.

## Naming-Quickref

| Konstrukt       | Stil                              | Beispiel                        |
| --------------- | --------------------------------- | ------------------------------- |
| Klasse          | `Gg<X>` PascalCase                | `GgRouterDelegate`              |
| Datei           | snake_case mit `gg_`-Prefix       | `gg_router_delegate.dart`       |
| Test-Datei      | `<filename>_test.dart`            | `gg_router_delegate_test.dart`  |
| Privates Member | `_camelCase`                      | `_updateState`                  |
| Konstante       | `lowerCamelCase` (kein SCREAMING) | `carriageReturn`                |
| Enum-Wert       | `lowerCamelCase`                  | `GgStatusPrinterStatus.success` |

## Was nicht zu tun ist

- **Keine** `dynamic`-Rückgabetypen (`always_declare_return_types`
  ist ein Error).
- **Keine** Double Quotes (`prefer_single_quotes`).
- **Keine** Mutation von Public Feldern; Setter nur mit klarer
  Begründung.
- **Keine** TODO-Kommentare ohne Issue-/Ticket-Referenz.
- **Keine** auskommentierten Codeblöcke "für später" — Git ist die
  History.
