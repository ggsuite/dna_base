<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Review

- Complain when translations are missing.
- See [multi-language-guide.md](../multi-language-guide.md)
- Complain in the review when a public API was changed and it was not
  added to the README.md

## Review checklist (per changed file)

### Guides

- Walk through the guides in doc/de|en/guides and check what needs to be
  adjusted in the code so that all guides are fulfilled

### Redundancy / DRY

- Identical or nearly identical blocks in the diff or its direct
  neighborhood.
- Functions that already exist in the repo but are not reused.
- Duplicate imports, duplicate test setups, copied constants.

### Clarity

- Functions longer than ~10 lines — suggest extraction, but only if
  it is clearly more readable.
- Nesting deeper than 3 levels (`if`/`for`/`try`) — suggest
  early returns.
- Names that do not match the conventions or the purpose.
- Magic numbers / strings that would be clearer as named constants.

### Performance

- `await` in a loop that could be parallelized
  (`Future.wait`).
- Repeated `.where().toList()` in hot paths.
- `List.add` in tight loops where `List.generate` or a
  pre-allocated buffer would be better.
- Stream subscriptions without `cancel`, timers without `cancel`,
  `StreamController` without `close`.
- Synchronous IO (`readAsStringSync`, `existsSync`) in
  async code paths.
- Repeated parsing/computing that belongs outside the loop.

### Security

- Secrets in the diff: check for `API_KEY`, `SECRET`, `PASSWORD`,
  `TOKEN`, plus JWT-/Base64-like long strings in new lines.
- `Process.run` / `Process.start` with interpolated user input →
  shell injection risk.
- Input validation at system boundaries (HTTP handlers, CLI args).
- File paths from external sources without normalization →
  path traversal risk.
- New dependencies in the manifest: actively maintained? Known
  maintainers? Plausible score? If not assessable, report as a
  suggestion.

## Interactive fix loop

Walk through all blockers: show the patch per finding,
apply / skip / edit (edit = the user describes an
alternative, a new patch is proposed).
