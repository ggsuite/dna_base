# dna_base

The base DNA used by many of our projects (ggsuite, rljson, tssuite,
ds_cdm, …). It ships the ecosystem-neutral foundation every repo
inherits via [gg_dna](https://github.com/ggsuite/gg_dna):

- `dna/.vscode/` — shared editor settings and extension recommendations
- `dna/LICENSE` — the MIT license template (`dnaCopyrightHolder`,
  `dnaCopyrightYear` variables)
- `dna/doc/` — the canonical developer guides (ticket workflow
  `develop.md`, install guides, org guides)
- `dna/scripts/` — repo-management node scripts
- `dna/_vars.json` — the base variable defaults (`company`,
  `copyrightHolder`, `gitOrgUrl`, `projectName`, …)

## Usage

Declare it as a dev-dependency and initialize once:

```bash
pnpm add -D dna_base        # TypeScript projects
dart pub add dev:dna_base   # Dart projects
gg_dna init
```

The placed test instantiates and verifies the DNA on every test run.
Ecosystem layers ([dna_dart](https://github.com/ggsuite/dna_dart),
[dna-ts](https://github.com/tssuite/dna-ts)) build on top of this
package — consumers usually depend on those instead of dna_base
directly.

## Development

This repo has `role: "dna"` in `.gg/dna.json`: the `dna/` folder is
authored by hand, never generated. The repo instantiates its own DNA —
run `dart test` after changes; commit first (a file the DNA would
overwrite must not carry uncommitted work).
