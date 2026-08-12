# Changelog

## 1.1.1 - 2026-08-12

## 1.1.0 - 2026-08-09

### Changed

- Resolve DNA like dart or npm packages

### Fixed

- Fix issues in markdown overrides

## 1.0.1 - 2026-08-08

### Fixed

- Fix pana issues

## 1.0.0 - 2026-08-05

### Added

- gg_dna 5.0 replica layout: `dna/` mirrors the project root
- `dna/_vars.json` with the base variable defaults (`company`,
`copyrightHolder`, `copyrightYear`, `gitOrgUrl`, `projectName`)
- `dna/LICENSE` MIT template with variable placeholders
- `dna/.vscode/settings.json` + `extensions.json` (ecosystem-neutral
split of the former template project settings)
- `dna/doc/develop.md` — canonical ticket workflow with replaceable
ecosystem sections (`[@updateDependencies]`, `[@increaseVersion]`,
`[@runTestsAndBuild]`, `[@publish]`)
- Docs migrated from the numbered folders, flattened and translated to
English; org guides (gg-kidney, rljson) taken over from
gg_dna_ggsuite
- `dna/scripts/` node repo-management scripts (English headers)
- Hybrid packaging: npm + pub `base_dna`; `role: "dna"` with
self-instantiation via the placed DNA test

## 0.0.2 - 2026-08-07

### Changed

- Define dna repos
- Define DNA repos

## 0.0.1 - 2026-08-05

### Added

- Add scripts
