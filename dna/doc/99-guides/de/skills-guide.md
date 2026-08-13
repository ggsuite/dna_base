<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Skills-Guide

Wie Claude-Code-Skills in dnaCompany-Repos ausgeliefert und
geschrieben werden. Skills sind paketierte Anweisungen, die Claude
Code für eine bestimmte Art von Aufgabe lädt. Die DNA verteilt sie
über `dna/dot-claude/skills/`, instanziiert nach `.claude/skills/`
jedes konsumierenden Repos.

## Ausgelieferte Skills

| Skill         | Zweck                                                            |
| ------------- | ---------------------------------------------------------------- |
| `init`        | DNA-bewusste `CLAUDE.md` (+ `dna/_override/PROJECT_STRUCTURE.md`) für das Repo anlegen |
| `new-project` | Neues Paket/Repository mit `gg_create_package` anlegen           |
| `new-ticket`  | Multi-Repo- oder Single-Repo-Ticket via `gg` anlegen             |
| `review`      | Voller Branch-Review: erst Tooling-Checks, dann konventionsbasierter Code-Review |

## Anatomie eines Skills

Ein Ordner pro Skill mit einer `SKILL.md`:

```text
dot-claude/skills/<skill-name>/SKILL.md
```

`SKILL.md` beginnt mit YAML-Frontmatter:

```markdown
---
name: <skill-name>
description: <was er tut + wann er getriggert wird>
---

# <Titel>

<Anweisungen an den Agenten>
```

- **`name`** entspricht dem Ordnernamen.
- **`description`** trägt zwei Dinge: was der Skill tut, und die
  **Trigger-Phrasen** ("verwende diesen Skill automatisch, wenn der
  Nutzer sinngemäß sagt …"). Die Description ist das, was der Agent
  sieht, wenn er über den Aufruf entscheidet — hier investieren.
- Der **Body** ist als direkte Anweisung an den Agenten geschrieben,
  imperativ, mit nummerierten Schritten in Ausführungsreihenfolge.

## Regeln fürs Schreiben von Skills

Aus den ausgelieferten Skills extrahiert — in neuen befolgen:

- **Bestätigung vor Seiteneffekten.** Jeder Schritt, der etwas
  anlegt, ändert oder löscht, wird vorher angekündigt und vom Nutzer
  bestätigt. Nur lesende Schritte dürfen frei laufen.
- **Nie Flags oder Pfade raten.** Erst `-h` ausführen
  (`gg_create_package -h`, `gg -h`) und Aufrufe aus der Hilfe-Ausgabe
  konstruieren. Maschinenabhängige Pfade (Workspace-Root,
  Repo-Eltern-Ordner) erfragen oder per Suche finden — nie
  hartkodieren.
- **Sauber degradieren.** Fehlt ein Tool (`gg` nicht installiert),
  melden und weiterlaufen oder stoppen — nie Ergebnisse mocken.
- **Nicht überfragen.** Wenn der Nutzer Name, Branch oder Repo-Liste
  schon vorgegeben hat, nicht erneut fragen — nur Fehlendes klären
  und am Ende einmal bestätigen lassen.
- **Mit Wrap-up enden.** Melden, was wo angelegt wurde (absolute
  Pfade), und nächste Schritte vorschlagen — aber nicht ungefragt
  ausführen.
- **Die harten "Nie"-Regeln** in einer abschließenden
  "Wichtig"-Sektion festhalten: nie ungefragt pushen, nie publishen,
  nie Inhalte erfinden.

## Skill vs. Guide

- **Guides** (`doc/99-guides/`) definieren, wie im Repo gearbeitet
  wird. Sie werden über den Managed CLAUDE.md-Block importiert und
  sind damit immer geladen — siehe
  [DNA-Design-Guide](./dna-design-guide.md).
- **Skills** beschreiben, wie ein konkreter Workflow Schritt für
  Schritt ausgeführt wird — sie laden bei Bedarf.

Wo sich die beiden überlappen, konsistent halten: Eine
Workflow-Änderung landet zuerst im Guide, dann im Skill, der sie
automatisiert.
