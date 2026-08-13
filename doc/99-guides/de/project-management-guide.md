<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Project-Management-Guide

Wie Arbeit bei ggsuite organisiert ist: Jede Änderung passiert in
einem **Ticket**, und neue Pakete werden mit dem Standard-Tooling
angelegt.

## Tickets

Es gibt zwei Ticket-Modi — nach Scope wählen:

- **Multi-Repo-Ticket** — Änderungen betreffen mehrere Repos, oder es
  ist noch unklar, welche Repos gebraucht werden → Ticket im
  gg-Ticket-Workspace.
- **Single-Repo-Ticket** — Bug oder Feature betrifft eindeutig genau
  ein Repo → Ticket-Branch direkt im Repo.

### Multi-Repo-Ticket

Der gg-Ticket-Workspace ist der Ordner mit `.ocean/` (Legacy-Name
`.master/`, wird automatisch umbenannt) und einem `tickets/`-Ordner.

```bash
cd <workspace>
gg do ls repos                                  # available repos
gg do create ticket <ticket-id> -m '<description>'
cd tickets/<ticket-id>
gg do add <repo1> <repo2> ...
gg do code                                      # open VS Code workspace
```

- `gg do create ticket` legt `tickets/<ticket-id>/` an, mit
  Ticket-Datei (ID + Beschreibung), VS-Code-Workspace-Datei und
  Trash-Ordner.
- Welche Repos zum Ticket gehören, wird durch Lesen der `index.md`
  der Kandidaten-Repos entschieden (Zusammenfassung, Domäne,
  Schnittstellen) — siehe [Index-Guide](./index-guide.md).
- `gg do add` klont die Repos ins Ticket, checkt in jedem den Branch
  `<ticket-id>` aus und stellt Intra-Workspace-Abhängigkeiten auf
  lokale Pfade um. Lokale Abhängigkeiten der gewählten Repos werden
  automatisch mitgenommen — lieber zu wenige Repos hinzufügen als zu
  viele.
- Repo-Namen müssen exakt mit den Ordnernamen unter `.ocean/`
  übereinstimmen.

### Single-Repo-Ticket

```bash
cd <repo>
git pull            # before creating the ticket, never after
gg one do create ticket <branch-name> -m '<description>'
```

Das checkt einen neuen Ticket-Branch aus und schreibt eine
Ticket-Datei. Vorhandene lokale Änderungen bleiben erhalten (werden
gestasht und auf dem neuen Branch wieder angewendet).

### Ticket-Benennung

- **Ticket-ID = Branch-Name.** Kurz und sprechend, im Stil der
  bestehenden Tickets: `gGS-123` oder `fix_login_crash`.
- **Beschreibung:** Ein bis zwei Sätze zum Problem oder Feature;
  landet in der Ticket-Datei.

## Neue Pakete anlegen

Neue Pakete werden mit `gg_create_package` angelegt — nie durch
Kopieren eines bestehenden Repos oder handgebautes Boilerplate.

```bash
gg_create_package -h    # always check current flags first
gg_create_package -n <name> -g <github-org> \
  -d "<description with at least 60 characters>" [--no-open-source]
```

- Im Eltern-Ordner ausführen, in dem die Geschwister-Repos liegen.
- **Paketname = Repo-Name = Klassen-Prefix**, den Team-Prefixes
  (`gg_`, `kidney_`, `ds_`, …) folgend, wo sie passen.
- Die Beschreibung muss **mindestens 60 Zeichen** lang sein, sonst
  lehnt `gg_create_package` ab.
- Explizit entscheiden: GitHub-Org, Open Source ja/nein,
  Flutter-Paket ja/nein.
- `gg_create_package` liefert die Standard-Struktur — kein
  zusätzliches Boilerplate, keine CI-Configs, keine Lizenzen obendrauf.

Nach dem Anlegen: lokal committen, dann `git push -u origin main`.
Wenn das Remote bereits Commits hat (vorbefülltes Repo mit
README/LICENSE), erst prüfen, was dort liegt, und nur nach expliziter
Absprache mit `--force-with-lease` force-pushen.

## Der tägliche Ablauf

Implementierung, Commits, Pushes, Reviews und Publishen sind im
[Develop-Guide](./develop-guide.md), [Review-Guide](./review-guide.md)
und [Publish-Guide](./publish-guide.md) beschrieben.
