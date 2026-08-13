<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review-Guide

Wie Änderungen in ggsuite-Projekten reviewt werden. Dieser Guide
ist das **vollständige Review-Verfahren** — der `review`-Skill führt
ihn aus, und ein menschlicher Reviewer folgt denselben Phasen. Er
umfasst den `gg`-Review-Workflow und die fünf Review-Phasen: Scope →
Tooling → Checkliste → Bericht → Fixes.

In JS-/TS-Repos läuft `gg` als `npx @tssuite/gg-js` — die Kommandos
unten gelten für beide Ökosysteme.

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

## Phase 0 — Scope ermitteln

Vor jeder Prüfung den Scope klären und melden:

1. **Repo-Root:** `git rev-parse --show-toplevel`. Schlägt das fehl,
   „kein Git-Repo" melden und stoppen.
2. **Basis-Branch:** `git symbolic-ref refs/remotes/origin/HEAD`
   (typischerweise `refs/remotes/origin/main`); Fallback `main`, dann
   `master`; wenn keine Basis ermittelbar ist, nach dem Basis-Branch
   fragen.
3. **Diff-Range:** `<basis>...HEAD` (drei Punkte — gegen die
   Merge-Base).
4. **Geänderte Dateien:** `git diff --name-status <basis>...HEAD`,
   plus `git status --porcelain` für untracked / uncommitted Dateien.
5. **Multi-Repo-Workspace?** Gehören mehrere Repos zum Ticket, diese
   auflisten; Phasen 1–2 laufen seriell pro Sub-Repo, der
   Phase-3-Bericht wird zusammengefasst, Phase 4 läuft wieder pro
   Sub-Repo.

Den Scope kurz melden:

```text
Review scope:
  Repo:    <abs-path>
  Branch:  <feature-branch> vs <base-branch>
  Files:   N changed (+L / -L), M untracked
  Mode:    single repo  |  workspace with K sub-repos: …
```

## Phase 1 — Tooling zuerst (interaktiv, blockierend)

Deterministische Checks kommen zuerst — ein Review von Code, der nicht
mal durchs Tooling kommt, verschwendet die Zeit aller. Diese Phase
läuft, **bis alle Checks grün sind**; jeder Fix wird einzeln
vorgeschlagen und bestätigt, dann läuft der Check erneut.

1. **Dependency-Tightening:** `dart pub upgrade --tighten` (bzw. das
   Äquivalent des Ökosystems). War das Manifest vorher dirty, warnen,
   dass zusätzliche Änderungen auftauchen können. Den Diff zeigen und
   fragen, ob er Teil des Commits wird — gebündelt in Phase 4
   committen, nicht sofort.
2. **`gg one can commit`** — analyze, format, tests und **100 %
   Coverage** in einem seiteneffektfreien Check (gg 16+; die früheren
   `gg one check …`-Befehle existieren nicht mehr).

Hinweise zum Test-Schritt:

- Die Tests enthalten den **platzierten DNA-Test**, der die DNA
  instanziiert und prüft — ein separates Sync-Kommando existiert
  nicht (siehe [DNA-Design-Guide](./dna-design-guide.md)). Von ihm
  generierte Dateien werden automatisch als `#gg: generated DNA`
  committet — diesen Commit wie jede andere Änderung reviewen. Meldet
  er eine von Hand editierte Instanz, die Änderung in die genannte
  DNA-Quelle verschieben — nie die generierte Datei anpassen.
- **Coverage unter 100 % ist ein Blocker** — die nicht abgedeckten
  Zeilen lokalisieren und in Phase 2 als Findings behandeln.
- Fehlschlagende Tests einzeln auflisten (Datei, Testname, Meldung);
  pro Test entscheiden, ob Test oder Code falsch ist, den Fix als
  konkreten Patch vorschlagen.

Die Phase mit einem kurzen Wrap-up abschließen (Tightening
angewendet? Checks ok? Coverage? DNA-Test ok?) — erst dann Phase 2
beginnen.

## Phase 2 — Review-Checkliste (pro geänderter Datei)

Nur die geänderten Dateien aus Phase 0 reviewen; andere Dateien nur
als Kontext für ein Finding lesen (z. B. Aufrufer einer geänderten
Funktion). Pro Datei: den Diff lesen, dann die volle Datei, dann gegen
jede Achse prüfen.

### Konventionen

Die Konventionen sind **die Guides**: den Diff gegen den
[Architecture-Guide](./architecture-guide.md),
[Test-Guide](./test-guide.md), [Documentation-Guide](./doc-guide.md),
[Develop-Guide](./develop-guide.md) prüfen — und den
[CLI-Guide](./cli-guide.md), wenn CLI-Ausgaben geändert wurden. Jedes
Konventions-Finding mit einem Zitat aus dem Guide belegen — das
schützt vor Geschmacks-Findings.

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
  wurden (beide README-Sprachen).

### Performance

Typische Fallen — nur was im Diff steht oder direkt davon getriggert
wird:

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

Nicht spekulieren — ein Finding nur, wenn der Hot Path plausibel ist
(läuft pro Frame, pro Request, pro Element einer großen Collection).

### Sicherheit

- **Secrets im Diff:** auf `API_KEY`, `SECRET`, `PASSWORD`, `TOKEN`
  prüfen, plus JWT-/Base64-artige lange Strings in neuen Zeilen.
- **`Process.run` / `Process.start`** mit interpoliertem User-Input →
  Shell-Injection-Risiko.
- **Input-Validierung** an Systemgrenzen (HTTP-Handler, CLI-Args).
- **Datei-Pfade aus externen Quellen** ohne Normalisierung →
  Path-Traversal-Risiko.
- **Neue Dependencies** im Manifest: aktiv gepflegt? Bekannte
  Maintainer? Plausibler Score? Wenn nicht beurteilbar, als
  Suggestion melden, nicht als Blocker.

## Phase 3 — Der Bericht

Alle Findings aus Phase 1 und 2 in **einen strukturierten Bericht**
sammeln, bevor irgendein Fix angewendet wird. Klassifikation:

- **Blocker** — verhindert den Merge: Tooling-Fehler (auch
  dokumentieren, wenn in Phase 1 schon gefixt), Coverage < 100 %,
  Security-Findings mit klarem Risiko, fehlende Doku auf Public API,
  Konventions-Verletzungen.
- **Suggestion** — sollte gefixt werden, aber kein Hard-Stop: DRY /
  Performance / Übersichtlichkeit mit klarer Begründung,
  README-/CHANGELOG-Updates.
- **Nit** — Stil, optional: Naming-Mikro-Optimierungen, leichte
  Lesbarkeit.

Format:

````markdown
## Review: <branch> vs <base>

**Tooling**
- static checks: PASS / FAIL (fixed in phase 1: yes/no)
- tests:         PASS / FAIL (coverage: NN%, DNA test: PASS / FAIL)
- dependency tightening: manifest changed (yes/no)

**Statistics**
- Files: N changed, +L / -L
- Findings: X blockers, Y suggestions, Z nits

---

### Blockers

#### B1. <short title> — `<file>:<line>`
**Convention/axis**: <guide §… | Performance | Security | …>
**Finding**: <one to three sentences>
**Patch**:
```diff
- old line
+ new line
```

### Suggestions

#### S1. …

### Nits

#### N1. …
````

Leere Kategorien als `(none)` ausweisen statt sie wegzulassen — so
ist sichtbar, dass die Kategorie tatsächlich geprüft wurde.

## Phase 4 — Interaktiver Fix-Loop

Nach dem Bericht drei Modi anbieten:

1. **Alle Blocker durchgehen** — pro Blocker den Patch zeigen,
   apply / skip / edit (edit = der Nutzer beschreibt eine
   Alternative, ein neuer Patch wird vorgeschlagen).
2. **Cherry-Pick** — der Nutzer wählt per Nummer aus, welche Findings
   gefixt werden.
3. **Abbrechen** — der Bericht steht, der Nutzer fixt selbst.

Wenn Patches angewendet wurden:

1. **Regressionsprüfung:** `gg one can commit` erneut laufen lassen.
   Wenn rot, melden und zurück in Phase 1.
2. **Commit-Vorschlag:** eine Message, die die Review-Fixes
   zusammenfasst (eine separate, wenn das Dependency-Tightening das
   Manifest geändert hat) — zeigen, nie ungefragt committen:

   ```text
   review: fix blockers from review run

   - <B1 title>
   - <B2 title>
   ```

3. **Push:** nie ungefragt.

## Regeln

- Nie Dateien ändern, committen oder pushen ohne Bestätigung — jeder
  Fix wird einzeln bestätigt.
- Nie einen Tooling-Fehler als gefixt melden, ohne den Check erneut
  laufen gelassen zu haben.
- Tooling-Wahrheit schlägt Reviewer-Geschmack: Was Analyzer oder
  Tests sagen, ist Fakt; subjektive Punkte sind Suggestions.
- Nie ein Finding erfinden, nur damit eine Sektion nicht leer ist;
  und Performance-/Security-Findings nie ohne konkrete Risiko- bzw.
  Hot-Path-Begründung als Blocker einstufen.
- Wenn der Nutzer Phasen überspringt („nur Phase 2, Tooling habe ich
  selbst geprüft"), das respektieren und oben im Bericht vermerken.
