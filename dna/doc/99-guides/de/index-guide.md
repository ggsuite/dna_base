<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Index-Guide

Jedes Repo trägt eine **`index.md` in seinem Hauptverzeichnis**. Sie
wird **von Claude gelesen, um zu entscheiden, welche Repos einem
Ticket hinzugefügt werden müssen** — beim Anlegen eines Tickets
scannt der Agent die `index.md`-Dateien der verfügbaren Repos und
wählt die aus, deren Domäne und Schnittstellen zur Aufgabe passen
(siehe [Project-Management-Guide](./project-management-guide.md)).

## Inhalt

Drei Dinge, **möglichst tokensparend**:

1. **Kurze Zusammenfassung** des Projekts — was dieses Repo macht.
2. **Domäne / Ziel** — welchen Problemraum es besitzt.
3. **Schnittstellen zu anderen Repos** — wovon es abhängt, was von
   ihm abhängt, und über welche API die Kopplung läuft.

## Template

```markdown
# <pkg>

<1–2 Sätze: Was dieses Repo macht.>

## Domain / Goal

<Welchen Problemraum dieses Repo besitzt. 1–3 Stichpunkte.>

## Interfaces

- uses `<repo-a>`: <wofür / über welche API>
- used by `<repo-b>`: <wofür / über welche API>
```

## Regeln

- **Token-Ökonomie zuerst.** Die Datei wird bei jeder Ticket-Planung
  von einem Agenten für jedes Repo im Workspace gelesen — jeder
  überflüssige Satz kostet bei jedem Scan. Keine Prosa, die die
  README wiederholt.
- **README ist für Menschen, index.md für Agenten.** Beide
  marketingfrei, aber die index.md ist radikal komprimiert:
  Stichworte schlagen ganze Sätze.
- **Die Schnittstellen sind der Kern.** Ob ein Repo zu einem Ticket
  gehört, entscheidet sich meist an seinen Kopplungen — die
  Schnittstellen-Liste präzise und aktuell halten.
- **Bei Änderung aktualisieren.** Ändern sich Ziel oder
  Schnittstellen, aktualisiert dasselbe Ticket die `index.md`.
