<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Blog-Guide

Wie Blog-Posts in dnaCompany-Repos geschrieben werden. Blog-Posts
dokumentieren das "Warum" und "Wie" einer Änderung, während sie
passiert — sie sind der erzählende Begleiter zu Commits und
Changelog-Einträgen.

## Ablage und Benennung

Blog-Posts liegen unter `doc/blog/`, pro Sprache und Jahr, eine Datei
pro Post:

```text
doc/blog/en/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
doc/blog/de/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
```

Beispiel: `doc/blog/en/2026/2026-08-12-distribute-dna-via-npm.md`

Jeder Post existiert in beiden Sprachen mit demselben Dateinamen —
siehe [Multi-Language-Guide](./multi-language-guide.md).

## Umfang

**Ein bis zwei Bildschirmseiten.** Gut zusammengefasst — ein Post ist
ein Digest, kein Protokoll. Bei größeren Refactorings gerne auch mehr.

## Pflichtstruktur

```markdown
# <Titel des Blog-Posts>

## Motivation

<Warum, wozu und für wen. Das größere Ziel.>

## Strategie

<Wie das Ziel erreicht werden soll. 3–7 Stichpunkte.>

## Umsetzung 1

...

## Umsetzung 2

...

## Offene Punkte

...
```

## Sektion für Sektion

- **Motivation** — warum, wozu und für wen. Das größere Ziel nennen,
  dem die Änderung dient, nicht nur den unmittelbaren Auslöser.
- **Strategie** — wie das Ziel erreicht werden soll, als **3–7
  Stichpunkte**. Das ist der Plan auf einen Blick.
- **Umsetzung 1, 2, …** — eine Sektion pro Umsetzungsschritt oder
  Arbeitspaket. So viele wie nötig; jede fokussiert halten.
- **Offene Punkte** — was noch nicht fertig ist, bekannte
  Einschränkungen, vertagte Entscheidungen.

## Wann Posts geschrieben werden

Blog-Posts werden **immer beim Publishen angelegt** — jedes Publish
wird von einem Post über das **aktuelle Ticket** begleitet. Den Post
zu schreiben ist Teil der Publish-Routine, kein optionales Extra —
siehe [Publish-Guide](./publish-guide.md).

## Regeln

- Blog-Posts aus der Documentation-Sektion des READMEs verlinken —
  siehe [README-Guide](./readme-guide.md).
- Ein Post pro Ticket: Der Post fasst zusammen, was das Ticket
  geändert hat; das Datum im Dateinamen ist das Publish-Datum.
- Lieber mehrere kleine Posts als ein endlos wachsender: Ein
  Folge-Ticket bekommt eine eigene Datei mit neuem Datum.
