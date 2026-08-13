<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Multi-Language-Guide

Dokumentation existiert in **zwei Sprachen: Englisch (`en`) und
Deutsch (`de`)**. Beide sind gleichberechtigt — keine ist "die
Übersetzung, die hinterherhinkt".

## Was in beiden Sprachen existiert

- **README:** `README.md` (Englisch) und `README.de.md` (Deutsch),
  nebeneinander im Repo-Root.
- **Guides:** `doc/99-guides/en/` und `doc/99-guides/de/` — gleiche
  Dateinamen in beiden Ordnern.
- **Blog-Posts:** `doc/blog/en/<yyyy>/` und `doc/blog/de/<yyyy>/` —
  gleiche Dateinamen in beiden Bäumen (siehe
  [Blog-Guide](./blog-guide.md)).

Dateinamen bleiben in beiden Bäumen **identisch** (englische Namen);
nur der Inhalt wird übersetzt. Die README ist mit ihrem
`.de.md`-Suffix die Ausnahme, weil beide Varianten im selben Ordner
liegen.

## Die Sync-Regel

`en` und `de` sind Spiegel:

- Jede Datei hat ein Gegenstück mit gleichem Namen in der anderen
  Sprache.
- **Wird eine `de`-Datei geändert, wird die korrespondierende
  `en`-Datei in derselben Änderung aktualisiert — und andersherum.**
  Die beiden Sprachen laufen nie auseinander.
- Eine Datei ohne Gegenstück, oder eine Änderung, die nur eine
  Sprache berührt, ist ein Review-Finding.

## Arbeitsteilung für KI

Als KI bearbeitest du **standardmäßig immer die `en`-Dateien** und
passt danach die korrespondierenden `de`-Dateien an — nie andersherum.
Nur wenn der Nutzer explizit an einer `de`-Datei arbeitet, dreht sich
der Ablauf: dann wird direkt danach das `en`-Gegenstück aktualisiert.

## Übersetzungsregeln

- **Inhaltsgleich, nicht wortwörtlich.** Beide Versionen sagen
  dasselbe; idiomatische Formulierung schlägt wörtliche Übersetzung.
- **Unübersetzt bleiben:** Kommandos, Code-Blöcke, Dateipfade,
  API-Namen und etablierte Fachbegriffe. Ein deutscher Satz um
  `gg do commit` herum ist richtig; ein übersetztes Kommando nicht.
- **Strukturgleich:** gleiche Überschriften (übersetzt), gleiche
  Reihenfolge, gleiche Beispiele — damit Leser mitten im Dokument die
  Sprache wechseln können, ohne sich zu verlieren.
