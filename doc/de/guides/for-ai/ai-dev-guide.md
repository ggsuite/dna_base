<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Development guide for AI

## Frage die Infos zum Ticket vom  Entwickler ab

- Frage die Ticket-ID ab
- Frage den Titel des Tickets ab
- Frage die Beschreibung des Tickets ab

## Ersetze in diesem Dokumen

- Ersetze `~/dev/` durch das Workspace-Verzeichnis aus der Erinnerung
- Frage das Workspace Verzeichnis ab, wenn keines bekannt ist
- Ersetze `gGS-145` durch die abgefragte Ticket-ID
- Ersetze `Fix issue abc` durch den abgefragten Ticket-Titel

## Lege ein Ticket an

```bash
cd ~/dev/ # workspace
gg do create ticket gGS-145 -m"Fix issue abc"
cd tickets/gGS-145
```

## Füge Git-Repositories hinzu

Schau dir die `index.md` eines jeden Repos in .ocean an und entscheide welche
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

## Öffne den Workspace in Vscode

```bash
gg do code
```

## Implementiere

Implementiere deine Features auf Basis der Guides

## Committe

```bash
gg do commit
```

## Pushe

```bash
gg do push
```

## Review

Lass dir durch den Nutzer bestätigen, dass die Review-Phase gestartet wird.

```bash
gg do review
```

gg erstellt Pull Requests für jedes Repo und gibt die URLs im Terminal
aus.

Lade danach den review-light Skill und führe ihn aus.

## Publishe

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
