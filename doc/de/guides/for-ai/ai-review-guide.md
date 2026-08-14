<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review

- Beschwere Dich, wenn Übersetzungen fehlen.
- Siehe [multi-language-guide.md](multi-language-guide.md)
- Beschwere Dich im Review, wenn eine Public API geändert wurde, und diese
  nicht im README.md eingetragen wurde

## Review-Checkliste (pro geänderter Datei)

### Guides

- Gehe die guides in `doc/de|en/guides` durch und schaue was im Code angepasst
  angepasst werden muss dass alle Guides erfüllt sind

### Redundanz / DRY

- Identische oder fast identische Blöcke im Diff oder seiner direkten
  Nachbarschaft.
- Funktionen, die im Repo bereits existieren, aber nicht
  wiederverwendet werden.
- Doppelte Imports, doppelte Test-Setups, kopierte Konstanten.

### Übersichtlichkeit

- Funktionen über ~10 Zeilen — Extraktion vorschlagen, aber nur, wenn
  sie klar besser lesbar ist.
- Verschachtelung tiefer als 3 Ebenen (`if`/`for`/`try`) —
  Early-Returns vorschlagen.
- Namen, die nicht zu den Konventionen oder dem Zweck passen.
- Magic Numbers / Strings, die als benannte Konstanten klarer wären.

### Performance

- `await` in einer Schleife, das parallelisierbar wäre
  (`Future.wait`).
- Wiederholtes `.where().toList()` in heißen Pfaden.
- `List.add` in engen Schleifen, wo `List.generate` oder ein
  vor-allokierter Buffer besser wäre.
- Stream-Subscriptions ohne `cancel`, Timer ohne `cancel`,
  `StreamController` ohne `close`.
- Synchrone IO (`readAsStringSync`, `existsSync`) in
  async-Code-Pfaden.
- Wiederholtes Parsen/Berechnen, das außerhalb der Schleife gehört.

### Sicherheit

- Secrets im Diff: auf `API_KEY`, `SECRET`, `PASSWORD`, `TOKEN`
  prüfen, plus JWT-/Base64-artige lange Strings in neuen Zeilen.
- `Process.run` / `Process.start` mit interpoliertem User-Input →
  Shell-Injection-Risiko.
- Input-Validierung an Systemgrenzen (HTTP-Handler, CLI-Args).
- Datei-Pfade aus externen Quellen ohne Normalisierung →
  Path-Traversal-Risiko.
- Neue Dependencies im Manifest: aktiv gepflegt? Bekannte
  Maintainer? Plausibler Score? Wenn nicht beurteilbar, als
  Suggestion melden.

## Interaktiver Fix-Loop

Alle Blocker durchgehen: pro Finding den Patch zeigen,
apply / skip / edit (edit = der Nutzer beschreibt eine
Alternative, ein neuer Patch wird vorgeschlagen).
