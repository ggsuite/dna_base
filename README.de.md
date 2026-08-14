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

Um diese DNA in deinem Projekt zu verwenden, schaue in den
[dna/doc/de/guides/dna-guide.md](DNA guide).

## Entwicklung

Dieses Repo hat `role: "dna"` in `dna/_dna.json`: Der `dna/`-Ordner
wird von Hand gepflegt, nie generiert. Das Repo instanziiert seine
eigene DNA — nach Änderungen `dart test` ausführen; vorher committen
(eine Datei, die die DNA überschreiben würde, darf keine
uncommitteten Änderungen tragen).
