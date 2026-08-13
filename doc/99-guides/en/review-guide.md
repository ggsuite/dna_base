<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review Guide

How changes in ggsuite projects are reviewed. This guide is the
**complete review procedure** — the `review` skill executes it, and a
human reviewer follows the same phases. It covers the `gg` review
workflow and the five review phases: scope → tooling → checklist →
report → fixes.

In JS/TS repos, `gg` runs as `npx @tssuite/gg-js` — the commands below
apply to both ecosystems.

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

## Phase 0 — Determine the scope

Clarify and report the scope before checking anything:

1. **Repo root:** `git rev-parse --show-toplevel`. If that fails,
   report "not a git repo" and stop.
2. **Base branch:** `git symbolic-ref refs/remotes/origin/HEAD`
   (typically `refs/remotes/origin/main`); fall back to `main`, then
   `master`; if none can be determined, ask for the base branch.
3. **Diff range:** `<base>...HEAD` (three dots — against the merge
   base).
4. **Changed files:** `git diff --name-status <base>...HEAD`, plus
   `git status --porcelain` for untracked / uncommitted files.
5. **Multi-repo workspace?** If several repos belong to the ticket,
   list them; phases 1–2 run serially per sub-repo, the phase-3
   report is combined, phase 4 runs per sub-repo again.

Report the scope briefly:

```text
Review scope:
  Repo:    <abs-path>
  Branch:  <feature-branch> vs <base-branch>
  Files:   N changed (+L / -L), M untracked
  Mode:    single repo  |  workspace with K sub-repos: …
```

## Phase 1 — Tooling first (interactive, blocking)

Deterministic checks come first — a review of code that does not even
pass the tooling wastes everyone's time. This phase runs **until all
checks are green**; every fix is proposed and confirmed individually,
then the check reruns.

1. **Dependency tightening:** `dart pub upgrade --tighten` (or the
   ecosystem's equivalent). If the manifest was dirty beforehand, warn
   that extra changes may appear. Show the resulting diff and ask
   whether it becomes part of the commit — committed bundled in
   phase 4, not immediately.
2. **`gg one can commit`** — analyze, format, tests and **100 %
   coverage** in one side-effect-free check (gg 16+; the former
   `gg one check …` commands no longer exist).

Notes on the test step:

- The tests include the **placed DNA test**, which instantiates and
  verifies the DNA — a separate sync command does not exist (see the
  [DNA Design Guide](./dna-design-guide.md)). Files it generates are
  committed automatically as `#gg: generated DNA` — review that
  commit like any other change. When it reports a hand-edited
  instance, move the edit into the DNA source it names — never adjust
  the generated file.
- **Coverage below 100 % is a blocker** — locate the uncovered lines
  and treat them as findings in phase 2.
- Failing tests are listed individually (file, test name, message);
  decide per test whether the test or the code is wrong, propose the
  fix as a concrete patch.

Close the phase with a short wrap-up (tightening applied? checks ok?
coverage? DNA test ok?) — only then start phase 2.

## Phase 2 — Review checklist (per changed file)

Review only the changed files from phase 0; read other files only as
context for a finding (e.g. callers of a changed function). Per file:
read the diff, then the full file, then check against every axis.

### Conventions

The conventions are **the guides**: check the diff against the
[Architecture Guide](./architecture-guide.md),
[Test Guide](./test-guide.md), [Doc Guide](./doc-guide.md),
[Develop Guide](./develop-guide.md) — and the
[CLI Guide](./cli-guide.md) when CLI output changed. Back every
convention finding with a quote from the guide — that protects
against taste findings.

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
  it — check whether they changed in the diff (both README languages).

### Performance

Typical pitfalls — only what is in the diff or directly triggered by
it:

- `await` in a loop that could be parallelized (`Future.wait`).
- Repeated `.where().toList()` in hot paths.
- `List.add` in tight loops where `List.generate` or a pre-allocated
  buffer would be better.
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
- **Input validation** at system boundaries (HTTP handlers, CLI args).
- **File paths from external sources** used without normalization →
  path traversal risk.
- **New dependencies** in the manifest: actively maintained? Known
  maintainers? Plausible score? If not assessable, report as a
  suggestion, not a blocker.

## Phase 3 — The report

Collect all findings from phases 1 and 2 into **one structured
report** before any fix is applied. Classification:

- **Blocker** — prevents merge: tooling failures (documented even when
  already fixed in phase 1), coverage < 100 %, security findings with
  a clear risk, missing docs on public API, convention violations.
- **Suggestion** — should be fixed, but no hard stop: DRY /
  performance / clarity with a clear rationale, README/CHANGELOG
  updates.
- **Nit** — style, optional: naming micro-optimizations, minor
  readability.

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

Report empty categories as `(none)` instead of dropping them — that
shows the category was actually checked.

## Phase 4 — Interactive fix loop

After the report, offer three modes:

1. **Walk through all blockers** — per blocker show the patch, apply /
   skip / edit (edit = the user describes an alternative, a new patch
   is proposed).
2. **Cherry-pick** — the user selects by number which findings to fix.
3. **Abort** — the report stands, the user fixes things themselves.

When patches were applied:

1. **Regression check:** rerun `gg one can commit`. If red, report and
   loop back to phase 1.
2. **Commit proposal:** one message summarizing the review fixes (a
   separate one when dependency tightening changed the manifest) —
   shown, never committed unasked:

   ```text
   review: fix blockers from review run

   - <B1 title>
   - <B2 title>
   ```

3. **Push:** never unasked.

## Rules

- Never change files, commit or push without confirmation — every fix
  is confirmed individually.
- Never report a tooling failure as fixed without rerunning the check.
- Tooling truth beats reviewer taste: what the analyzer or the tests
  say is a fact; subjective points are suggestions.
- Never invent a finding just to fill a section; and never classify
  performance/security findings as blockers without a concrete risk or
  hot-path rationale.
- When the user skips phases ("only phase 2, I checked the tooling
  myself"), respect that and note it at the top of the report.
