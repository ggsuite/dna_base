<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Develop-Guide

Wie `gg` für die tägliche Entwicklung bei dnaCompany benutzt wird.
Git-Operationen laufen **immer über `gg`** (v15+), nie über rohes
`git commit` / `git push`. `gg` führt vor jedem Commit die Checks aus
(analyze, format, tests, 100 % Coverage), pflegt den Changelog und
erzwingt den Branch-Guard — rohes Git umgeht all das.

> **Veraltet:** `kd` existiert nicht mehr. Alle alten
> `kd do …`-Befehle sind durch `gg …` ersetzt; `gg multi` ist nur noch
> ein verstecktes Alias für die Root-Kommandos.

## Zwei Modi: `gg` (Workspace) und `gg one`

`gg` erkennt selbst, wo es läuft:

- **Ticket-Workspace** — ein Verzeichnisbaum mit `.ocean/`
  (Legacy-Name `.master/` wird automatisch umbenannt) oder `tickets/`:
  `gg <cmd>` läuft als `gg_multi` über **alle Repos des Tickets in
  Dependency-Reihenfolge**.
- **Standalone-Projekt** (`pubspec.yaml`, `package.json` oder
  `tsconfig.json`): explizit `gg one <cmd>` verwenden. Ein bloßes
  `gg do commit` führt dort nichts aus und verweist auf `gg one`.
- `gg one` funktioniert auch **innerhalb** eines Ticket-Workspace,
  wenn ein Befehl gezielt nur ein einzelnes Repo betreffen soll.

## Branches und Tickets

- **Nie auf `main`/`master` committen.** `gg do commit` verweigert das
  mit einer Fehlermeldung. `--force` ist die dokumentierte Notluke —
  nur mit explizitem menschlichem OK.
- **Branch-Name = Ticket-ID.** `gg do add <repo>` checkt in jedem
  hinzugefügten Repo den Branch mit dem Ticket-Namen aus.
- Ticket-IDs sind kurz und sprechend, im Stil der bestehenden Tickets
  (z. B. `dnaJiraPrefix-123` oder `fix_login_crash`).
- Siehe [Project-Management-Guide](./project-management-guide.md) zum
  Anlegen von Tickets und Hinzufügen von Repos.

## Der tägliche Ablauf

```bash
cd tickets/<ticket-id>   # or the standalone repo
gg do code               # open the VS Code workspace
# ... implement ...
gg can commit            # check without side effects
gg do commit -m 'Add dashboard export'
gg can push
gg do push
```

Für Standalone-Repos alles mit `one` prefixen: `gg one can commit`,
`gg one do commit -m '...'`, `gg one do push`.

- **`can` vor `do`:** `gg can commit` prüft ohne Seiteneffekte
  (analyze + format + tests + Coverage). `gg do commit` führt die
  Checks ohnehin aus und bricht bei Rot ab — rote Checks nie mit
  `--force` umgehen.
- **`gg do push`** merged vorher `main` in den Feature-Branch und
  pusht; im Workspace für alle Ticket-Repos in
  Dependency-Reihenfolge. Offene Pull Requests werden dadurch
  automatisch aktualisiert.
- Commits klein und logisch geschnitten — eine Änderungseinheit pro
  `gg do commit`, keine Sammel-Commits über unabhängige Themen.

## Commit-Messages

- **Englisch, imperativ, ein prägnanter Satz** ("Add dashboard
  export", "Fix race condition in dispose").
- `gg do commit -m` schreibt die Message **automatisch in den
  CHANGELOG** (Dart-Projekte). Die Changelog-Sektion wird aus der
  Message abgeleitet:

  | Message …             | CHANGELOG-Sektion |
  | --------------------- | ----------------- |
  | beginnt mit `add`     | Added             |
  | enthält `change`      | Changed           |
  | enthält `deprecate`   | Deprecated        |
  | enthält `fix`         | Fixed             |
  | enthält `remove`      | Removed           |
  | enthält `secure`      | Security          |
  | sonst                 | Changed           |

  Messages so formulieren, dass das Mapping greift — ein Bugfix
  beginnt mit "Fix …", ein neues Feature mit "Add …".
- `--no-log` nur, wenn ein Commit bewusst keinen Changelog-Eintrag
  bekommen soll (selten).
- **Keine Co-Authored-By-Trailer** und keine sonstigen Auto-Trailer.

## Zustandsabfragen

`gg did commit`, `gg did push`, `gg did review` melden, ob der
aktuelle Stand committed / gepusht / reviewt ist. Diese Befehle
verwenden, statt `git log` / `git status` von Hand zu interpretieren.

## Review und Publish

- Reviews laufen über `gg do review` — siehe
  [Review-Guide](./review-guide.md).
- Publishen läuft über `gg do publish` und ist **Menschen
  vorbehalten** — siehe [Publish-Guide](./publish-guide.md).

## Was rohes Git noch darf

Nur **lesende** Operationen: `git status`, `git log`, `git diff`,
`git show`, `git blame`. Außerdem `git pull` auf `main` vor der
Ticket-Anlage. Alles Schreibende (commit, push, merge, rebase, tag)
läuft über `gg`.

## Was nicht zu tun ist

- **Kein** manuelles `git commit` / `git push` / `git merge`.
- **Keine** Commits auf `main`/`master`; `--force` ist nie der
  Normalfall.
- **Keine** roten Checks umgehen (`--force`, Test-Skips,
  Coverage-Ignores) — erst fixen, dann committen.
- **Kein** `gg do publish` durch Agenten.
- **Keine** `kd`-Befehle — Doku oder Skripte, die `kd` erwähnen, sind
  veraltet und sollten gemeldet werden.
