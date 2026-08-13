<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# DNA-Design-Guide

Wie das DNA-System funktioniert und wie DNA-Pakete entworfen werden.
Die DNA hält eine Familie von Repositories konsistent: Gemeinsame
Guides, Claude-Skills, Skripte und Konfiguration werden **einmal** in
DNA-Paketen geschrieben und in jedes konsumierende Projekt
**instanziiert**.

Zwei Dinge werden leicht verwechselt:

- **Helix ist die Engine** (früher `gg_dna`) — sie löst DNA auf,
  merged und instanziiert sie. Sie liefert keinen `dna/`-Ordner aus
  und damit keinen eigenen Inhalt.
- **Die DNA ist der Inhalt** — sie lebt in DNA-Paketen (`dna_base`,
  `dna_dart`, `dna-ts`, `ds-dna`, …). Dort wird alles editiert, was
  Projekte erben sollen.

## Das Replica-Layout

Ein DNA-Paket ist ein normales pub-/npm-Paket mit einem
`dna/`-Ordner. Dieser Ordner ist eine **Replik des Projekt-Roots** —
Helix kopiert seinen Inhalt an die echten Orte, die Kopien heißen
**Instanzen**:

| Pfad in der DNA                        | Instanziiert nach              |
| -------------------------------------- | ------------------------------ |
| `dna/dot-vscode/settings.json`         | `.vscode/settings.json`        |
| `dna/LICENSE`                          | `LICENSE`                      |
| `dna/doc/99-guides/en/test-guide.md`   | `doc/99-guides/en/test-guide.md` |
| `dna/dot-claude/skills/init/SKILL.md`  | `.claude/skills/init/SKILL.md` |
| `dna/_vars.json`                       | — (privat)                     |

- **Dotfiles werden escaped** mit dem Prefix `dot-`, weil
  `dart pub publish` jeden Pfad mit führendem Punkt stillschweigend
  verwirft — ein unescaptes `dna/.vscode/` erreicht einen
  pub-installierten Konsumenten nie. `dot-` ist die einzige
  akzeptierte Form; ein `dot_`-escapter Pfad lässt den platzierten
  Test mit der erwarteten Umbenennung fehlschlagen.
- **Privat:** Pfad-Segmente mit führendem `_` (`_vars.json`,
  `_drafts/…`) bleiben in `dna/` und werden nie instanziiert.
- **Von Helix selbst konsumiert:** `*.overrides.md`-,
  `*.overrides.json`-Sidecars, `global.overrides.md` und die beiden
  Manifeste `_dna.json` / `_generated.json`.
- **Verbotene Instanz-Ziele:** `.git/**` und `CLAUDE.md` — eine
  `dna/CLAUDE.md` wird mit Warnung übersprungen. `CLAUDE.md` wird
  stattdessen über den Managed Block befüllt (siehe unten).
- **Dateinamen werden exakt so instanziiert, wie sie geschrieben
  sind** — keine Case-Konvertierung. Unsere Naming-Regel: Bindestriche
  für alle DNA-Ordner und -Dateien (`test-guide.md`, `dot-claude/`);
  nur Dart-Ordner (`lib/`, `test/`) nutzen snake_case, weil Dart es
  verlangt.

## Verteilung: Dependencies + Vererbung

DNA-Pakete werden über die normalen Package-Manager verteilt — kein
Klonen, kein eigenes Fetching:

- Ein **Projekt** deklariert seine DNA(s) als Dev-Dependencies
  (`pubspec.yaml` / `package.json`).
- Eine **DNA** deklariert ihre Eltern-DNAs als reguläre Dependencies —
  pub und pnpm installieren den ganzen Vererbungsbaum transitiv.
- **Layer werden über den Paketnamen benannt**, nie über einen Pfad.
  Lock-Dateien pinnen die Identität (Ökosystem, Version);
  `node_modules/` und `.dart_tool/package_config.json` liefern den
  Ort.
- Eine in beide Registries publizierte DNA ist **ein** Layer: Der
  npm-Scope wird beim Falten der Namen entfernt, `@tssuite/dna-base`,
  `dna_base` und `dna-base` sind dieselbe Identität (node gewinnt,
  wenn beide installiert sind).
- Für lokale Entwicklung zeigt `gg_localize_refs`
  `pubspec_overrides.yaml` / `pnpm-workspace.yaml` auf die
  Geschwister-Checkouts — Helix folgt dem, was der Package-Manager
  aufgelöst hat.

**Merge-Reihenfolge:** Die `layers`-Liste ist die einzige
Wahrheitsquelle — Eltern vor Kindern, Diamanten dedupliziert (die
erste topologische Position gewinnt), Zyklen sind Fehler. **Der
letzte Layer gewinnt** bei Pfad-Kollisionen.

## Rollen: `dna/_dna.json`

`dna/_dna.json` ist der einzige Ort für DNA-Konfiguration (innerhalb
von `dna/`, weil das der eine Ordner ist, den beide Ökosysteme
publizieren). Ein `dna/`-Ordner **ohne** `_dna.json` ist ein harter
Fehler.

```jsonc
{
  "version": 1,                    // required
  "role": "project",               // "dna" for DNA packages
  "layers": ["dna_base"],          // package names, application order
  "vars": { "dnaProjectName": "my_project" },
  "claude": { "claudeMdInclude": ["doc/99-guides/en"] }
}
```

- **`role: "project"`** (Default) — ein Konsument: `dna/` wird
  vollständig von Helix generiert. Nie editieren — außer `_dna.json`,
  die gehört dir.
- **`role: "dna"`** — ein DNA-Repository: `dna/` wird von Hand
  geschrieben, nie überschrieben, und auf das Repo selbst als letzter
  (gewinnender) Layer angewendet — ein DNA-Repo isst sein eigenes
  Hundefutter. Diese Deklaration macht ein Paket überhaupt erst als
  Layer nutzbar.

Helix *liest* `_dna.json` nur. Seine Buchführung — aufgelöste Layer,
Versionen, Hashes und die Liste der Instanzen, die ihm gehören —
landet in `dna/_generated.json`: maschineneigen, nie von Hand
editieren.

## Der platzierte Test: instanziieren + prüfen bei jedem Testlauf

`helix init` ist das einzige CLI-Kommando (`helix sync` wurde
entfernt). Es platziert einen Wrapper-Test (`test/dna/dna_test.dart`
und/oder `test/dna/dna.spec.ts`) und das `_dna.json`-Skelett. Ab dann
**instanziiert jeder Testlauf die DNA**: Layer auflösen → mergen →
Overrides anwenden → Variablen ersetzen → mit dem Projekt abgleichen.

| Situation                                   | Ergebnis |
| ------------------------------------------- | -------- |
| Alles aktuell                               | Grün, keine Schreibzugriffe |
| Die DNA erzeugte Updates                    | Dateien geschrieben und committet als `#gg: generated DNA` |
| Eine Instanz wurde lokal editiert           | DNA-Inhalt gewinnt; die lokale Änderung wird in einen System-Temp-Ordner gesichert, der Pfad ausgegeben |
| Eine Nicht-Instanz-Datei würde überschrieben und trägt uncommittete Arbeit | Test schlägt fehl ohne zu schreiben, benennt jede Datei |
| `LICENSE` fehlt                             | Test schlägt fehl |

Daraus folgende Regeln:

- **Instanzen gehören der DNA.** Um eine zu ändern, den Layer
  editieren, dem sie gehört (bzw. `dna/` in einem `role: dna`-Repo) —
  der nächste Testlauf verteilt die Änderung. Hand-Edits an Instanzen
  werden überschrieben (der Backup-Pfad wird ausgegeben).
- **Per-File-Guard:** Jede andere Datei, die ein Lauf überschreiben
  würde, muss vorher committet sein — DNA-Änderungen erscheinen immer
  als reviewbarer Diff auf einem Commit. Unbeteiligte dirty Dateien
  blockieren nie.
- Bestehende Projekt-Dateien, die eine DNA ebenfalls ausliefert,
  werden **adoptiert** (überschrieben — die Git-History ist das
  Backup). Instanzen, die kein Layer mehr erzeugt, werden entfernt,
  samt leer zurückbleibender Ordner.

Einstieg in einem Konsumenten:

```bash
dart pub add --dev dna_dart helix   # declare DNA(s) + engine
dart run helix init                 # place test + config skeleton
git add -A && git commit -m 'Add DNA'
dart test                           # first run instantiates + commits
```

## Overrides: höhere Layer patchen tiefere

### Markdown (`X.overrides.md`)

Die Ziel-Datei bietet zwei Arten von Ankern:

- `## [@tag] Heading` markiert die ganze Sektion als ersetzbar.
- `{{@tag:default}}` markiert einen Inline-String mit Default.

Ein höherer Layer liefert `X.overrides.md` neben demselben Pfad, mit
Heading-Blöcken (ersetzen die Sektion) oder
`<!-- @tag --> … <!-- @tag -->`-Blöcken (ersetzen den String). Eine
`global.overrides.md` im `dna/`-Root eines Layers ersetzt String-Tags
in **allen** Dateien tieferer Layer. Marker überleben die
Layer-Anwendung — auch noch höhere Layer können erneut überschreiben —
und werden aus den finalen Instanzen entfernt. Code-Fences und
Inline-Code werden nie angefasst.

### JSON (`X.overrides.json`)

Eine gleichpfadige `X.json` in einem späteren Layer ersetzt die Datei.
Ein Sidecar `X.overrides.json` merged feldweise:

- Objekte deep-mergen, Skalare ersetzen,
- `"key": null` löscht den Key,
- `"key!"` ersetzt den Wert komplett (kein Merge),
- `"key+"` hängt an ein Array an (dedupliziert).

JSONC (Kommentare, trailing Commas) wird toleriert; strukturell
gepatchte Dateien werden kommentarfrei neu ausgegeben, unberührte
byte-identisch kopiert. YAML unterstützt nur Ganz-Datei-Ersetzung.

## Variablen

Layer definieren Variablen in `dna/_vars.json` — camelCase-Keys, die
mit `dna` **beginnen müssen** (ein Key ohne Prefix lässt den
platzierten Test fehlschlagen). Variablen-Dateien deep-mergen über
die Layer (`null` löscht); die `vars` der Ziel-`_dna.json`
überschreiben zuletzt. Referenzen werden case-adaptiv in jeder
Text-Datei ersetzt:

| Referenz           | Wird zu (Wert `my-project`) |
| ------------------ | --------------------------- |
| `dnaProjectName`   | `myProject`                 |
| `DnaProjectName`   | `MyProject`                 |
| `dna_project_name` | `my_project`                |
| `DNA_PROJECT_NAME` | `MY_PROJECT`                |
| `dna-project-name` | `my-project`                |

Nicht-Identifier-Werte (Sätze, Leerzeichen) werden in allen Formen
wörtlich eingesetzt; unbekannte Referenzen bleiben stehen. Werte
dürfen andere Variablen referenzieren (expandiert bis stabil,
höchstens 10 Durchläufe; Zyklen werden erkannt und mit dem
schließenden Pfad gemeldet).

## CLAUDE.md: der Managed Block

`CLAUDE.md` ist nie eine DNA-Instanz. Stattdessen listet
`claude.claudeMdInclude` in der Ziel-`_dna.json` Dateien/Ordner, die
je eine `@`-Import-Zeile zwischen `<!-- helix:claude_md:start -->`
und `<!-- helix:claude_md:end -->` bekommen — Ordner expandieren zu
ihren `.md`-Dateien, fehlende Einträge lassen den Lauf fehlschlagen.
Claude Code expandiert die Imports bei jedem Session-Start; wer
`doc/99-guides/en` listet, macht damit **alle Guides zur
Pflichtlektüre bei jedem Start**. Inhalt außerhalb des Blocks gehört
dem Projekt und wird nie angefasst.

## Design-Regeln für DNA-Inhalt

- **Die DNA editieren, nie die Instanz, nie Helix.** Eine Änderung
  landet im besitzenden Layer; der platzierte Test verteilt sie
  überallhin.
- **Ein Anliegen pro DNA-Paket.** `dna_base` trägt, was jedes Repo
  teilt; Sprach-DNAs (`dna_dart`, `dna-ts`) und Organisations-DNAs
  legen ihre Spezifika per Overrides obendrauf — sie forken keine
  Dateien.
- **Fürs Überschreiben entwerfen:** Sektionen (`## [@tag]`) und Werte
  (`{{@tag:default}}`) taggen, die höhere Layer plausibel ersetzen
  werden, statt sie zu zwingen, ganze Dateien zu duplizieren.
- **Variablen nutzen** (`dnaCompany`, `dnaGitOrgUrl`, …) statt Namen
  hart zu codieren — Konsumenten überschreiben sie in `_dna.json`.
- **Alles in `dna/` wird publiziert** — keine Secrets, keine Entwürfe
  außerhalb von `_`-Ordnern.
- Dokumentation wird für Menschen geschrieben; die KI konsumiert
  dieselben Dateien über den Managed CLAUDE.md-Block — siehe
  [Multi-Language-Guide](./multi-language-guide.md) für die
  en/de-Spiegel-Regel.
