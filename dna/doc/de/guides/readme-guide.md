<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# README-Guide

Wie eine README für dnaCompany-Pakete geschrieben wird. Knapp,
technisch, Englisch; kein Marketing.

## Pflichtstruktur

In dieser Reihenfolge:

````markdown
# <PackageName>

<1–3 Sätze: Was macht dieses Paket, welches Problem löst es?>

## Goals

- <3–7 Stichpunkte; jeder Punkt ist ein Ziel, keine Prosa-Aufsätze>

## Installation

<Alles, um es ans Laufen zu bringen: installieren, ausführen, als
Dependency einbinden.>

## Documentation

- <Verweise, keine Inhalte: Blog, Architektur-Doku und Guides
  (`doc/en/guides/`) verlinken>

## Code Examples

<Die wichtigsten Features, nicht alle. Jeder Schnipsel ohne Anpassung
lauffähig — kein Pseudo-Code, keine TODOs; synchron zu `example/`
(siehe [Example-Guide](./example-guide.md)).>

```dart
import 'package:<pkg>/<pkg>.dart';

void main() async {
  // Minimalbeispiel, das ohne Anpassung lauffähig ist
}
```

## Contributing

<Ticket-Workflow, Commit-/Review-Regeln — auf
[Develop-Guide](./develop-guide.md) und
[Review-Guide](./review-guide.md) verlinken statt sie zu
wiederholen.>

## Open Bugs

- <ALLE offenen Bugs, je ein Stichpunkt, idealerweise mit Issue-Link>
````

## Optionale Ergänzungen

- `## State` mit CI-Badge:

  ```markdown
  [![Dart Script Execution](dnaGitOrgUrl/<pkg>/actions/workflows/check.yaml/badge.svg)](...)
  ```

- `## Classes` als Tabelle bei Mehr-Klassen-Paketen.
- `## How It Works` für nicht-triviale Mechaniken.
- Inhaltsverzeichnis bei langen READMEs (manuell gepflegt).

## Regeln

- Das Intro beantwortet "was & warum" in höchstens drei Sätzen;
  Details liegen in den Sektionen darunter oder in der API-Doku.
- Eine geänderte Public API ohne README-Update ist ein
  Review-Finding.
- Ein gefixter Bug verlässt "Open Bugs" im selben Commit, der ihn
  behebt.
- `README.md` (en) und `README.de.md` (de) werden in derselben
  Änderung aktualisiert — siehe
  [Multi-Language-Guide](./multi-language-guide.md).
