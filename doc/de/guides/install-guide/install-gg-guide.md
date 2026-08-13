<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# gg installieren

`gg` ist die einheitliche Dart-CLI für die Entwicklung bei
ggsuite. Sie führt Pre-Commit-Checks in einem einzelnen Repository
aus und orchestriert Commits, Pushes, Reviews und Publishes über alle
Repositories eines Tickets.

## Voraussetzungen

Installiere zuerst [Flutter](./install-flutter-guide.md). Es liefert das
unten verwendete `dart`-Kommando.

```bash
dart --version
```

## gg installieren

```bash
dart pub global activate gg
```

## Pub-Cache zum PATH hinzufügen

Global aktivierte Dart-Executables landen im Pub-Cache. Füge dessen
`bin`-Ordner zu deinem `PATH` hinzu, sonst wird das `gg`-Kommando
nicht gefunden.

Mac und Linux:

```bash
echo 'export PATH="$HOME/.pub-cache/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Füge auf Windows folgenden Ordner zu deiner
`Path`-Umgebungsvariable hinzu:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

Starte danach dein Terminal neu.

## Installation prüfen

```bash
gg --help
```

## gg aktualisieren

Führe die Aktivierung erneut aus, um die neueste Version zu
installieren:

```bash
dart pub global activate gg
```

## Verwendung

`gg` ist ticketgetrieben: Führe es in einem Ticket aus, und jede
Aktion gilt für alle Repositories, die zu diesem Ticket gehören.

```bash
gg                # the command groups: do, can, did
gg do -h          # everything you can act on
gg can commit     # check before committing
```

Siehe auch den [Develop-Guide](../develop-guide.md).
