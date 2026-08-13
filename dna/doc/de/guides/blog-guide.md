<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Blog-Guide

Wie Blog-Posts in dnaCompany-Repos geschrieben werden. Blog-Posts
dokumentieren das Warum und Wie einer Änderung — der erzählende
Begleiter zu Commits und Changelog-Einträgen.

## Ablage und Benennung

Eine Datei pro Post, pro Sprache und Jahr:

```text
doc/en/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
doc/de/blog/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md
```

Beispiel: `doc/en/blog/2026/2026-08-12-distribute-dna-via-npm.md`

Beide Sprachen, gleicher Dateiname — siehe
[Multi-Language-Guide](./multi-language-guide.md).

## Umfang

Ein bis zwei Bildschirmseiten — ein Digest, kein Protokoll. Bei
größeren Refactorings gerne auch mehr.

## Pflichtstruktur

```markdown
# <Titel>

## Motivation

<Warum, wozu, für wen — das größere Ziel, nicht nur der Auslöser.>

## Strategie

<Wie das Ziel erreicht wird. 3–7 Stichpunkte.>

## Umsetzung 1, 2, …

<Eine fokussierte Sektion pro Umsetzungsschritt / Arbeitspaket.>

## Offene Punkte

<Noch nicht fertig, bekannte Einschränkungen, vertagte
Entscheidungen.>
```

## Regeln

- Werden immer beim Publishen angelegt: Jedes Publish bekommt einen
  Post über das aktuelle Ticket — siehe
  [Publish-Guide](./publish-guide.md).
- Ein Post pro Ticket; das Datum im Dateinamen ist das Publish-Datum.
  Folge-Tickets bekommen eine neue Datei, keine wachsende alte.
- Posts aus der Documentation-Sektion der README verlinken — siehe
  [README-Guide](./readme-guide.md).
