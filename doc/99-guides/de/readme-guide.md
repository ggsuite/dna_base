<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# README-Guide

Wie eine README für ggsuite-Pakete geschrieben wird. Ton: knapp,
technisch. Keine Marketing-Sätze.

## Pflichtstruktur

In dieser Reihenfolge:

````markdown
# <PackageName>

<1–3 Sätze: Was macht dieses Paket? Welches Problem löst es?>

## Goals

- <Was ist das Ziel dieses Repos?>
- <3–7 Stichpunkte>

## Installation

<Wie bringe ich das Projekt ans Laufen? Ausführung. Einbindung.>

## Documentation

- <Verweis auf den Blog>
- <Verweis auf die Architektur-Doku>
- <Verweise auf die Guides>

## Code Examples

<Die wichtigsten Features — nicht alle>

```dart
import 'package:<pkg>/<pkg>.dart';

void main() async {
  // Minimalbeispiel, das ohne Anpassung lauffähig ist
}
```

## Contributing

<Hinweise zur Mitarbeit an diesem Repo>

## Open Bugs

- <Alle offenen Bugs werden hier aufgelistet>
````

## Sektion für Sektion

- **Goals** — was dieses Repo erreichen will, als **3–7
  Stichpunkte**. Keine Prosa-Aufsätze; jeder Punkt ist ein Ziel.
- **Installation** — alles, was nötig ist, um das Projekt ans Laufen
  zu bringen: Installation, Ausführung und Einbindung in ein anderes
  Projekt (Dependency-Setup).
- **Documentation** — Verweise, keine Inhalte: Blog, Architektur-Doku
  und Guides (`doc/99-guides/`) verlinken. Die README bleibt der
  Einstiegspunkt, Details liegen hinter den Links.
- **Code Examples** — die **wichtigsten Features zeigen, nicht
  alle**. Jeder Schnipsel muss ohne Anpassung lauffähig sein — kein
  Pseudo-Code, kein `// TODO`. Die Schnipsel synchron zu `example/`
  halten (siehe [Example-Guide](./example-guide.md)).
- **Contributing** — wie an diesem Repo gearbeitet wird:
  Ticket-Workflow, Commit-/Review-Regeln. Auf
  [Develop-Guide](./develop-guide.md) und
  [Review-Guide](./review-guide.md) verlinken statt sie zu
  wiederholen.
- **Open Bugs** — **alle** offenen Bugs werden hier gelistet, je ein
  Stichpunkt, idealerweise mit Issue-Link.

## Optionale und übliche Ergänzungen

- **`## State`** mit CI-Badge:

  ```markdown
  [![Dart Script Execution](https://github.com/ggsuite/<pkg>/actions/workflows/check.yaml/badge.svg)](...)
  ```

- **`## Classes`** als Tabelle bei Mehr-Klassen-Paketen:

  ```markdown
  | Class    | Description                          |
  | :------- | :----------------------------------- |
  | `GgList` | Create lists of ordinary value types |
  ```

- **`## How It Works`** für nicht-triviale Mechaniken.
- **Inhaltsverzeichnis** bei langen READMEs (manuell gepflegt).

## Regeln

- Das Intro beantwortet "was & warum" in höchstens drei Sätzen;
  Details gehören in die Sektionen darunter oder in die API-Doku.
- Die README synchron zu Verhaltensänderungen halten — eine geänderte
  Public API ohne README-Update ist ein Review-Finding.
- Die "Open Bugs"-Liste ist pflege-kritisch: Ein gefixter Bug
  verlässt die Liste im selben Commit, der ihn behebt.
- Die README existiert auf Englisch (`README.md`) und Deutsch
  (`README.de.md`) — beide werden in derselben Änderung aktualisiert;
  siehe [Multi-Language-Guide](./multi-language-guide.md).
