<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review-Guide

Wie Änderungen in ggsuite-Projekten reviewt werden. Zwei Dinge
werden hier abgedeckt: der **`gg`-Review-Workflow** und die
**Review-Checkliste** für manuelle oder KI-gestützte Reviews.

## Der gg-Review-Workflow

- **`gg do review`** (im Ticket-Workspace): merged `main` in die
  Feature-Branches, pusht alle Repos, öffnet **einen Pull Request pro
  Repo** (URLs werden ausgegeben) und zeichnet den Review-Stand auf.
- Ein Reviewer stellt das Ticket lokal mit `gg do import ticket`
  wieder her.
- Review-Feedback normal einarbeiten:
  `gg do commit -m 'Address review comments'` und `gg do push` — die
  PRs aktualisieren sich automatisch.
- `gg did review` meldet, ob der aktuelle Stand reviewt ist.
- Ein Review ist **Voraussetzung fürs Publishen**: Commits nach dem
  letzten Review erfordern ein neues `gg do review`.

## Review-Reihenfolge: Tooling zuerst

Deterministische Checks kommen zuerst — ein Review von Code, der nicht
mal durchs Tooling kommt, verschwendet die Zeit aller:

1. `dart pub upgrade --tighten` — Dependency-Constraints aktuell?
2. `gg one can commit` — analyze, format, tests und **100 % Coverage**
   in einem seiteneffektfreien Check (gg 16+; die früheren
   `gg one check …`-Befehle existieren nicht mehr). Die Tests
   enthalten den platzierten DNA-Test, der die DNA instanziiert und
   prüft — ein separates Sync-Kommando existiert nicht (siehe
   [DNA-Design-Guide](./dna-design-guide.md)).

Tooling-Wahrheit schlägt Reviewer-Geschmack: Was Analyzer oder Tests
sagen, ist Fakt; subjektive Punkte sind Suggestions.

## Review-Checkliste (pro geänderter Datei)

Nur die geänderten Dateien reviewen; andere Dateien nur als Kontext
für ein Finding lesen (z. B. Aufrufer einer geänderten Funktion).

### Konventionen

Den Diff gegen die Konventions-Dokumente in `.claude/conventions/`
prüfen (Code, Test, Dokumentation, Git — und Farb-Konventionen, wenn
CLI-Ausgaben im Diff sind). Jedes Konventions-Finding mit einem Zitat
aus der Konventions-Datei belegen — das schützt vor
Geschmacks-Findings.

### Redundanz / DRY

- Identische oder fast identische Blöcke im Diff oder seiner direkten
  Nachbarschaft.
- Funktionen, die im Repo bereits existieren, aber nicht
  wiederverwendet werden.
- Doppelte Imports, doppelte Test-Setups, kopierte Konstanten.

### Übersichtlichkeit

- Funktionen über ~40 Zeilen — Extraktion vorschlagen, aber nur, wenn
  sie klar besser lesbar ist.
- Verschachtelung tiefer als 3 Ebenen (`if`/`for`/`try`) —
  Early-Returns vorschlagen.
- Namen, die nicht zu den Konventionen oder dem Zweck passen.
- Magic Numbers / Strings, die als benannte Konstanten klarer wären.

### Dokumentation

- **Korrektheit:** Doc-Comments gegen die tatsächliche Signatur
  abgleichen. Parameter umbenannt, aber Doc veraltet? Rückgabetyp
  geändert? Exceptions dokumentiert, die nicht mehr geworfen werden?
- **Vollständigkeit:** Public API ohne Doc-Comment → Blocker.
- **README/CHANGELOG:** Wenn sich öffentliches Verhalten geändert hat,
  müssen sie das widerspiegeln — prüfen, ob sie im Diff mitgeändert
  wurden.

### Performance

Typische Dart-Fallen — nur was im Diff steht oder direkt davon
getriggert wird:

- `await` in einer Schleife, das parallelisierbar wäre
  (`Future.wait`).
- Wiederholtes `.where().toList()` in heißen Pfaden.
- Stream-Subscriptions ohne `cancel`, Timer ohne `cancel`,
  `StreamController` ohne `close`.
- Synchrone IO (`readAsStringSync`, `existsSync`) in
  async-Code-Pfaden.
- Wiederholtes Parsen/Berechnen, das außerhalb der Schleife gehört.

Nicht spekulieren — ein Finding nur, wenn der Hot Path plausibel ist
(läuft pro Frame, pro Request, pro Element einer großen Collection).

### Sicherheit

- **Secrets im Diff:** auf `API_KEY`, `SECRET`, `PASSWORD`, `TOKEN`
  prüfen, plus JWT-/Base64-artige lange Strings in neuen Zeilen.
- **`Process.run` / `Process.start`** mit interpoliertem User-Input →
  Shell-Injection-Risiko.
- **Input-Validierung** an Systemgrenzen (HTTP-Handler, CLI-Args,
  Datei-Pfade aus externen Quellen; Path Traversal).
- **Neue Dependencies** in `pubspec.yaml`: aktiv gepflegt? Bekannte
  Maintainer? Plausibler Pub-Score? Wenn nicht beurteilbar, als
  Suggestion melden, nicht als Blocker.

## Findings klassifizieren

- **Blocker** — verhindert den Merge: Tooling-Fehler,
  Coverage < 100 %, Security-Findings mit klarem Risiko, fehlende
  Doku auf Public API, Konventions-Verletzungen.
- **Suggestion** — sollte gefixt werden, aber kein Hard-Stop: DRY /
  Performance / Übersichtlichkeit mit klarer Begründung,
  README-/CHANGELOG-Updates.
- **Nit** — Stil, optional: Naming-Mikro-Optimierungen, leichte
  Lesbarkeit.

Leere Kategorien als `(keine)` ausweisen statt sie wegzulassen — so
ist sichtbar, dass die Kategorie tatsächlich geprüft wurde. Nie ein
Finding erfinden, nur damit eine Sektion nicht leer ist; und
Performance-/Security-Findings nie ohne konkrete Risiko- bzw.
Hot-Path-Begründung als Blocker einstufen.
