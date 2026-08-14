# dna_base

Die Basis-DNA, die von vielen unserer Projekte verwendet wird
(ggsuite, rljson, tssuite, …). Sie liefert das
ökosystem-neutrale Fundament, das jedes Repo über
[helix](https://github.com/ggsuite/helix) erbt:

- `dna/dot-vscode/` — gemeinsame Editor-Einstellungen und
  Extension-Empfehlungen
- `dna/LICENSE` — das MIT-Lizenz-Template (Variablen
  `dnaCopyrightHolder`, `dnaYear`)
- `dna/doc/` — die kanonischen Entwickler-Guides auf Englisch und
  Deutsch (`doc/en/guides/`, `doc/de/guides/`: Develop-Guide,
  Install-Guides, …)
- `dna/scripts/` — Node-Skripte für die Repo-Verwaltung
- `dna/_vars.json` — die Basis-Variablen-Defaults (`dnaCompany`,
  `dnaCopyrightHolder`, `dnaGitOrgUrl`, `dnaProjectName`, …)

## Verwendung

Als Dev-Dependency deklarieren und einmalig initialisieren:

```bash
pnpm add -D @tssuite/dna-base   # TypeScript projects
dart pub add dev:dna_base       # Dart projects
helix init
```

Der platzierte Test instanziiert und verifiziert die DNA bei jedem
Testlauf. Ökosystem-Layer
([dna_dart](https://github.com/ggsuite/dna_dart),
[dna-ts](https://github.com/tssuite/dna-ts)) bauen auf diesem Paket
auf — Konsumenten hängen üblicherweise von diesen ab statt direkt von
dna_base.

## Entwicklung

Dieses Repo hat `role: "dna"` in `dna/_dna.json`: Der `dna/`-Ordner
wird von Hand gepflegt, nie generiert. Das Repo instanziiert seine
eigene DNA — nach Änderungen `dart test` ausführen; vorher committen
(eine Datei, die die DNA überschreiben würde, darf keine
uncommitteten Änderungen tragen).
