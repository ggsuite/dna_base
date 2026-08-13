# File Structure

```text
dna/                        # the hand-authored DNA (role: dna)
  _dna.json                 # DNA config: role, layers, claude imports
  _vars.json                # base variable defaults (dna* keys)
  _generated.json           # helix bookkeeping — machine-owned
  doc/
    01-install/             # install guides (VS Code, node, flutter, gg)
    02-develop/             # ticket workflow + repo creation
    99-guides/              # the guides, en/ and de/ mirrors
  dot-claude/skills/        # Claude skills → .claude/skills/
  dot-vscode/               # editor settings → .vscode/
  dot-prettierignore        # → .prettierignore
  dot-prettierrc            # → .prettierrc
  LICENSE                   # MIT license template (dna* variables)
  scripts/                  # repo-management node scripts
doc/                        # instances of dna/doc (edit dna/ instead)
  file-structure.md         # this file (project-owned, not an instance)
example/
  dna_base_example.dart     # runnable usage example
lib/
  dna_base.dart             # public API (barrel file)
  src/
    dna_base_version.dart   # version constant (Dart)
src/
  dna_base_version.ts       # version constant (TypeScript)
scripts/                    # instances of dna/scripts (edit dna/ instead)
test/
  dna/dna_test.dart         # placed test: instantiates + verifies the DNA
  dna_base_version_test.dart    # version constant matches pubspec (Dart)
  dna_base_version.test.ts      # version constant matches package.json (TS)
  version_sync_test.dart        # pubspec and package.json versions match
package.json                # npm packaging (@tssuite/dna-base)
pubspec.yaml                # dart packaging (dna_base)
```
