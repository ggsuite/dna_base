<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review Guide

How to review changes in ggsuite projects. Two things are covered
here: the **`gg` review workflow** and the **review checklist** used
for manual or AI-assisted reviews.

## The gg review workflow

- **`gg do review`** (in the ticket workspace): merges `main` into the
  feature branches, pushes all repos, opens **one pull request per
  repo** (URLs are printed) and records the review state.
- A reviewer restores the ticket locally with `gg do import ticket`.
- Address review feedback normally: `gg do commit -m 'Address review
  comments'` and `gg do push` — the PRs update automatically.
- `gg did review` reports whether the current state has been reviewed.
- A review is a **precondition for publishing**: commits after the
  last review require a new `gg do review`.

## Review order: tooling first

Deterministic checks come first — a review of code that does not even
pass the tooling wastes everyone's time:

1. `dart pub upgrade --tighten` — dependency constraints up to date?
2. `gg one can commit` — analyze, format, tests and **100 % coverage**
   in one side-effect-free check (gg 16+; the former
   `gg one check …` commands no longer exist). The tests include the
   placed DNA test, which instantiates and verifies the DNA — a
   separate sync command does not exist (see the
   [DNA Design Guide](./dna-design-guide.md)).

Tooling truth beats reviewer taste: what the analyzer or the tests say
is a fact; subjective points are suggestions.

## Review checklist (per changed file)

Review only the changed files; read other files only as context for a
finding (e.g. callers of a changed function).

### Conventions

Check the diff against the convention documents in
`.claude/conventions/` (code, test, documentation, git — and color
conventions when CLI output changed). Back every convention finding
with a quote from the convention file — that protects against taste
findings.

### Redundancy / DRY

- Identical or nearly identical blocks in the diff or its direct
  neighborhood.
- Functions that already exist in the repo but are not reused.
- Duplicated imports, duplicated test setups, copied constants.

### Clarity

- Functions beyond ~40 lines — suggest extraction, but only when the
  extraction clearly reads better.
- Nesting deeper than 3 levels (`if`/`for`/`try`) — suggest early
  returns.
- Names that do not match the conventions or the purpose.
- Magic numbers / strings that would be clearer as named constants.

### Documentation

- **Correctness:** compare doc comments against the actual signature.
  Renamed parameter but stale doc? Changed return type? Documented
  exceptions that are no longer thrown?
- **Completeness:** public API without doc comment → blocker.
- **README/CHANGELOG:** if public behavior changed, they must reflect
  it — check whether they changed in the diff.

### Performance

Typical Dart pitfalls — only what is in the diff or directly triggered
by it:

- `await` in a loop that could be parallelized (`Future.wait`).
- Repeated `.where().toList()` in hot paths.
- Stream subscriptions without `cancel`, timers without `cancel`,
  `StreamController` without `close`.
- Synchronous IO (`readAsStringSync`, `existsSync`) in async code
  paths.
- Repeated parsing/computation that belongs outside the loop.

Do not speculate — raise a finding only when the hot path is plausible
(runs per frame, per request, per element of a large collection).

### Security

- **Secrets in the diff:** check for `API_KEY`, `SECRET`, `PASSWORD`,
  `TOKEN`, plus JWT/Base64-like long strings in new lines.
- **`Process.run` / `Process.start`** with interpolated user input →
  shell injection risk.
- **Input validation** at system boundaries (HTTP handlers, CLI args,
  file paths from external sources; path traversal).
- **New dependencies** in `pubspec.yaml`: actively maintained? Known
  maintainers? Plausible pub score? If not assessable, report as a
  suggestion, not a blocker.

## Classifying findings

- **Blocker** — prevents merge: tooling failures, coverage < 100 %,
  security findings with a clear risk, missing docs on public API,
  convention violations.
- **Suggestion** — should be fixed, but no hard stop: DRY /
  performance / clarity with a clear rationale, README/CHANGELOG
  updates.
- **Nit** — style, optional: naming micro-optimizations, minor
  readability.

Report empty categories as `(none)` instead of dropping them — that
shows the category was actually checked. Never invent a finding just
to fill a section; and never classify performance/security findings as
blockers without a concrete risk or hot-path rationale.
