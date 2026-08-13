# dna_base

The base DNA used by many of our projects (ggsuite, rljson, tssuite,
ds_cdm, …). It ships the ecosystem-neutral foundation every repo
inherits via [helix](https://github.com/ggsuite/helix):

- `dna/dot-vscode/` — shared editor settings and extension
  recommendations
- `dna/LICENSE` — the MIT license template (`dnaCopyrightHolder`,
  `dnaCopyrightYear` variables)
- `dna/doc/` — the canonical developer guides in English and German
  (`doc/en/guides/`, `doc/de/guides/`: develop guide, install guides,
  …)
- `dna/scripts/` — repo-management node scripts
- `dna/_vars.json` — the base variable defaults (`dnaCompany`,
  `dnaCopyrightHolder`, `dnaGitOrgUrl`, `dnaProjectName`, …)

## Usage

Declare it as a dev-dependency and initialize once:

```bash
pnpm add -D @tssuite/dna-base   # TypeScript projects
dart pub add dev:dna_base       # Dart projects
helix init
```

The placed test instantiates and verifies the DNA on every test run.
Ecosystem layers ([dna_dart](https://github.com/ggsuite/dna_dart),
[dna-ts](https://github.com/tssuite/dna-ts)) build on top of this
package — consumers usually depend on those instead of dna_base
directly.

## Development

This repo has `role: "dna"` in `dna/_dna.json`: the `dna/` folder is
authored by hand, never generated. The repo instantiates its own DNA —
run `dart test` after changes; commit first (a file the DNA would
overwrite must not carry uncommitted work).
