<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# CLAUDE starten (Anweisung für den menschlichen Entwickler)

## Bereite vor

[Benötigte Software installieren](./install-guide.md)

[gg-Workspace vorbereiten](./install-guide/install-gg-workspace-guide.md)

## Öffne CLAUDE

```bash
claude
```

Gib CLAUDE die Anweisung für die Umsetzung eines Tickets.

# Arbeitsanweisung für CLAUDE (nach Eingabe der Aufgabe)

## Lege ein Ticket an

```bash
cd ~/dev/ # workspace
gg do create ticket gGS-145 -m"Fix issue abc"
cd tickets/gGS-145
```

## Füge Git-Repositories hinzu

Mache einen Plan wie du das Ticket grob umsetzen möchtest.
Schau dir die index.md eines jeden Repos in .ocean an und entscheide welche
Repos dem Ticket hinzugefügt werden müssen.
Falls gewisse Dinge bei der Umsetzung zu einer noch nicht vorhandenen Domain
im .ocean-ordner gehören, ziehe in Betracht ein neues Repository anzulegen.
Frage den Nutzer dazu. Erkläre dem Nutzer auch was du in welchem Repo grob
ändern möchtest um das Ticket umzusetzen und lass dir bestätigen, dass die
entsprechenden Repos zum Ticket hinzugefügt werden.

Nach Bestätigung vom Benutzer fügst du die Repos zum Ticket hinzu:

```bash
gg do add repo1 repo2
```

## Öffne den Workspace in Vscode

```bash
gg do code
```

## Implementiere

Implementiere deine Features

## Committe

```bash
gg do commit
```

## Pushe

```bash
gg do push
```

## Review

```bash
gg do review
```

gg erstellt Pull Requests für jedes Repo und gibt die URLs im Terminal
aus.

## Publishe

```bash
gg do publish
```

gg stößt den Pull-Request-Merge an und veröffentlicht die Änderungen
in der Registry. Zum Schluss wird der Versions-Tag angelegt und
gepusht.
