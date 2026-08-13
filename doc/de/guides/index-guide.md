<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Index-Guide

Jedes Repo hat eine `index.md` im Hauptverzeichnis. Claude liest sie
bei der Ticket-Planung, um zu entscheiden, welche Repos ein Ticket
braucht.

## Template

```markdown
# <pkg>

<1–2 Sätze: Was dieses Repo macht.>

## Domain / Goal

<1–3 Stichpunkte: Welchen Problemraum dieses Repo besitzt.>

## Interfaces

- uses `<repo-a>`: <wofür / über welche API>
- used by `<repo-b>`: <wofür / über welche API>
```

## Regeln

- So tokensparend wie möglich: Stichworte schlagen Sätze; keine Prosa,
  die die README wiederholt.
- Die Schnittstellen entscheiden die Ticket-Zugehörigkeit — präzise
  und aktuell halten.
- Ändern sich Ziel oder Schnittstellen, aktualisiert dasselbe Ticket
  die `index.md`.
