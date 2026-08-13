<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Multi-Language-Guide

Dokumentation existiert auf Englisch (`en`) und Deutsch (`de`); beide
sind gleichberechtigt.

## Struktur

- README: `README.md` (en) und `README.de.md` (de) im Repo-Root.
- Guides: `doc/en/guides/` und `doc/de/guides/`.
- Blog-Posts: `doc/en/blog/<yyyy>/` und `doc/de/blog/<yyyy>/` (siehe
  [Blog-Guide](./blog-guide.md)).

Dateinamen sind in beiden Bäumen identisch (englische Namen); nur die
README weicht mit ihrem `.de.md`-Suffix ab.

## Regeln

- `en` und `de` sind Spiegel: Jede Datei hat ein gleichnamiges
  Gegenstück, und eine Änderung an einer Sprache aktualisiert die
  andere in derselben Änderung.
- KI-Standard: erst `en` bearbeiten, dann `de` anpassen. Nur wenn der
  Nutzer an einer `de`-Datei arbeitet, dreht sich die Reihenfolge um.
- Inhalts- und strukturgleich übersetzen (gleiche Überschriften,
  Reihenfolge, Beispiele), nicht wortwörtlich. Kommandos, Code, Pfade
  und API-Namen bleiben unübersetzt.
- Ein fehlendes Gegenstück oder eine Änderung nur einer Sprache ist
  ein Review-Finding.
