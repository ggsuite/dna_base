<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Documentation-Guide

Wie dnaCompany-Projekte dokumentiert werden. Dokumentation ist
**funktional**, nicht "schön": Jedes Stück hat ein klares Ziel —
API-Verständnis, Reproduzierbarkeit, Nachvollziehbarkeit von
Änderungen.

## Doc-Comments im Code (`///`)

- Jeder Public Member hat einen `///`-Doc-Comment (Lint
  `public_member_api_docs` ist aktiv).
- **Was, nicht wie.** "Returns the list value at index `[i]`" — nicht
  "Loops through internal data and returns the i-th".
- **Konsistentes Tempus:** 3rd-Person-Indikativ ("Updates the
  state.", "Throws when ..."), kein "Will update", kein imperatives
  "Update the state.".
- **Parameter-Doku als Liste** mit der `- [name]`-Syntax:

  ```dart
  /// Run the operation and display the status.
  ///
  /// - [task] to be executed.
  ///   - If the task throws, an error state will be printed.
  ///   - If the task completes successfully, a success state will be printed.
  ```

- **Beispiele** im Doc-Comment nur, wenn der Aufruf nicht offensichtlich
  aus Signatur + Beschreibung folgt — dann als ` ```dart `-Block.
- **Throw-Verhalten** explizit machen, wenn relevant:
  `Throws a [StateError] when ...`.

## README.md

Siehe [README-Guide](./readme-guide.md) für die Pflichtstruktur.

## CHANGELOG.md

[Keep a Changelog](https://keepachangelog.com)-Stil:

```markdown
# Changelog

## [1.2.0] - 2026-04-29

### Added
- New `Foo.bar` factory.

### Changed
- Default of `useCarriageReturn` is now `!isGitHub`.

### Fixed
- Race condition in `dispose`.

## [1.1.5] - 2026-04-12
...

[1.2.0]: dnaGitOrgUrl/<pkg>/compare/1.1.5...1.2.0
[1.1.5]: dnaGitOrgUrl/<pkg>/compare/1.1.4...1.1.5
```

Regeln:

- **Reverse chronological** — Neuestes oben.
- **Sektionen** nur wenn relevant: `Added`, `Changed`, `Fixed`,
  `Removed` (manchmal `Deprecated`, `Security`).
- **Versions-Header:** `## [<semver>] - <YYYY-MM-DD>`; eckige Klammern
  bei verlinkten Versionen, Compare-Links am Datei-Ende.
- **Bullet-Items** sind kurz und imperativ ("Add X", "Fix Y").
- `gg do commit -m "..."` schreibt die Commit-Message automatisch in
  den Changelog. Manuelle Edits sind erlaubt, sollten aber selten
  nötig sein.

## example/

Siehe [Example-Guide](./example-guide.md).

## doc/file-structure.md

Die Projektstruktur des Repos, laufend von Claude beim Programmieren
gepflegt. Siehe [File-Structure-Guide](./file-structure-guide.md).

## Workflow-Dateien (.github/workflows/)

- `pipeline.yaml` — die Standard-Pipeline aus `gg_create_package`.
  Trigger auf `push` nach `main`; führt Checkout, SDK-Setup,
  `pub get`, `dart pub global activate gg` und die `gg`-Checks aus.
  **Nicht eigenmächtig ändern** — Pipeline-Änderungen laufen über das
  `gg`-Tooling oder Team-Absprache.
- `check.yaml` — die lokalen `gg`-Check-Schalter:

  ```yaml
  needsInternet: false
  analyze:
    execute: true
  format:
    execute: true
  tests:
    execute: true
  pana:
    execute: false # true for Flutter packages or before publishing
  ```

## CLAUDE.md

Die `CLAUDE.md` im Repo-Root wird von Claude Code automatisch geladen.
Sie enthält:

- **Den Managed Block**, gepflegt von Helix zwischen
  `<!-- helix:claude_md:start -->` und `<!-- helix:claude_md:end -->`:
  eine `@`-Import-Zeile pro Datei aus `claude.claudeMdInclude` der
  `dna/_dna.json` (Ordner expandieren zu ihren `.md`-Dateien). Wer
  `doc/99-guides/en` listet, macht alle Guides zur Pflichtlektüre bei
  jedem Session-Start — siehe
  [DNA-Design-Guide](./dna-design-guide.md).
- **Repo-spezifische Hinweise** außerhalb des Managed Blocks:
  Architekturskizze, Domain-Begriffe, projektspezifische Workflows.

Nicht in die CLAUDE.md gehören: Onboarding-Prosa, Marketing, alles,
was in README oder Code-Doku besser aufgehoben ist.

## Was nicht zu dokumentieren ist

- **Trivialitäten:** Ein Getter `length` braucht keinen Doc-Comment,
  der "Returns the length" erklärt — wenn der Lint einen verlangt,
  reicht die schlichte Variante.
- **"Wie der Code es tut":** Das sagt der Code. Doc-Comments erklären
  *was* und *warum*, nicht *wie*.
- **Persönliche Notizen,** "vielleicht später"-Pläne, "FIXME: ich
  verstehe das nicht" — nichts davon gehört ins Repo.
