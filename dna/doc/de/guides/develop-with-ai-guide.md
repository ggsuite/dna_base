<!--
@license
Copyright (c) dnaCopyrightHolder

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

# CLAUDE: Arbeitsanweisung (nach Eingabe der Aufgabe)

## CLAUDE: Lege ein Ticket an

```bash
cd ~/dev/ # workspace
gg do create ticket dnaJiraPrefix-145 -m"Fix issue abc"
cd tickets/dnaJiraPrefix-145
```

## CLAUDE: Füge Git-Repositories hinzu

Schau dir die index.md eines jeden Repos in .ocean an und entscheide welche
Repos dem Ticket hinzugefügt werden müssen.
Mache einen Plan wie du das Ticket grob umsetzen möchtest.
Falls gewisse Dinge bei der Umsetzung zu einer noch nicht vorhandenen Domain
im .ocean-ordner gehören, ziehe in Betracht ein neues Repository anzulegen.
Frage den Nutzer dazu. Erkläre dem Nutzer auch was du in welchem Repo grob
ändern möchtest um das Ticket umzusetzen und lass dir bestätigen, dass die
entsprechenden Repos zum Ticket hinzugefügt werden.

Nach Bestätigung vom Benutzer fügst du die Repos zum Ticket hinzu:

```bash
gg do add repo1 repo2
```

## CLAUDE: Öffne den Workspace in Vscode

```bash
gg do code
```

## CLAUDE: Implementiere

Implementiere deine Features auf Basis der Guides

## CLAUDE: Committe

```bash
gg do commit
```

## CLAUDE: Pushe

```bash
gg do push
```

## CLAUDE: Review

Lass dir durch den Nutzer bestätigen, dass die Review-Phase gestartet wird.

```bash
gg do review
```

gg erstellt Pull Requests für jedes Repo und gibt die URLs im Terminal
aus.

Lade danach den review-light Skill und führe ihn aus.

## CLAUDE: Publishe

- Lege einen Blog Post für das aktuelle Ticket an
- aktualisiere die index.md und README.md
- lege die Konfiguration für gg do publish an

Fordere den Benutzer auf **manuell** den folgenden Befehl auszuführen:
```bash
gg do publish
```

gg stößt den Pull-Request-Merge an und veröffentlicht die Änderungen
in der Registry. Zum Schluss wird der Versions-Tag angelegt und
gepusht.
