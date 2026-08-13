<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# API-Doc-Guide

Wie ggsuite-Projekte dokumentiert werden. Dokumentation ist
funktional, nicht "schön": API-Verständnis, Reproduzierbarkeit,
Nachvollziehbarkeit.

## Dateiaufbau

- `// @license`-Header am Dateianfang.
- `// ####…` (Rauten bis Spalte 80) vor jeder Top-Level-Klasse.
- `// ….` (Punkte bis Spalte 80) vor jedem Member, auch privaten.
- Public API zuerst, private Member am Ende hinter einem Label-Block;
  Untergruppen: kurze Punktzeile + Label.

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

## Doc-Comments (`///`)

- Public Member: ja; private: in der Regel nein. Reihenfolge:
  Trennzeile, `///`, Deklaration.
- Doku am Interface bzw. der Basisklasse schreiben;
  `@override`-Member wiederholen sie nicht — Dart erbt Doc-Comments.
- Ein Satz in einer Zeile, **maximal 3 Zeilen** (Umbruch bei Spalte
  80); mehr als eine nur für Caveats ("Important: …") und Throws
  (`Throws a [StateError] when …`). Ausnahme:
  `- [name]`-Parameterlisten dürfen länger sein.
- Englisch, 3rd-Person-Indikativ, was statt wie: "Returns …" — kein
  "Will return", kein Imperativ. Klassen: ein Satz.
- Andere Member mit `[name]` referenzieren; Konstruktor-Parameter:

  ```dart
  /// - [seed] The initial seed of the value.
  /// - [name] is an optional identifier for the value.
  ```

## Im Body

- Keine erklärenden Inline-Kommentare; nur Pragmas
  (`// coverage:ignore-line`, `// ignore: …`).

## Nicht dokumentieren

- Trivialitäten: Ein Getter `length` braucht keine Erklärung — wenn
  der Lint einen Doc-Comment verlangt, reicht die schlichte Variante.
- Wie der Code es tut — Doc-Comments erklären *was* und *warum*.
- Persönliche Notizen, "vielleicht später"-Pläne, FIXMEs.
