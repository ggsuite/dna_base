<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# File-Structure-Guide

Jedes Repo dokumentiert seine Projektstruktur in
**`doc/file-structure.md`**. Diese Datei wird **von Claude, laufend,
beim Programmieren** gepflegt: Immer wenn eine Änderung Dateien oder
Ordner anlegt, verschiebt, umbenennt oder löscht, wird
`doc/file-structure.md` in derselben Änderung aktualisiert.

## Warum eine Doc-Datei und nicht CLAUDE.md?

Diese Information stünde normalerweise in `CLAUDE.md`. Sie stattdessen
in `doc/file-structure.md` zu halten hat zwei Vorteile:

- Menschen lesen sie als Teil der normalen Dokumentation, nicht als
  Agent-Konfiguration.
- `CLAUDE.md` bleibt klein und verweist nur auf die Datei — der Agent
  lädt sie trotzdem.

## Format

Ein annotierter Baum: ein Eintrag pro relevanter Datei bzw. Ordner,
mit kurzem Kommentar zum Zweck.

````markdown
# File Structure

```text
lib/
  <pkg>.dart          # public API (barrel file)
  src/
    foo.dart          # <was foo macht>
test/
  foo_test.dart       # spiegelt lib/src/foo.dart
doc/
  blog/               # Blog-Posts, pro Sprache (en/de) und Jahr
  file-structure.md   # diese Datei
example/
  <pkg>_example.dart  # lauffähiges Usage-Beispiel
```
````

## Regeln

- **Immer aktuell.** Die Struktur-Datei ändert sich im selben Commit
  wie die strukturelle Änderung — nie als Nachzügler.
- **Zweck statt Inventar.** Jeder Eintrag trägt einen kurzen Kommentar,
  wofür die Datei bzw. der Ordner da ist. Triviales oder Generiertes
  (`node_modules/`, Build-Output) bleibt draußen.
- **Das Repo ist die Wahrheit.** Wenn Datei und Realität sich
  widersprechen, wird die Datei korrigiert — im Zuge der Änderung, die
  den Widerspruch bemerkt.
- **Verweisen statt duplizieren.** `CLAUDE.md` verlinkt auf
  `doc/file-structure.md`; die Struktur wird nicht an zwei Stellen
  gepflegt.
