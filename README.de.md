# dna_base

Die Basis-DNA, die von vielen unserer Projekte verwendet wird
(ggsuite, rljson, tssuite, ds_cdm, …). Sie liefert das
ökosystem-neutrale Fundament, das jedes Repo über
[gg_dna](https://github.com/ggsuite/gg_dna) erbt:

- `dna/.vscode/` — gemeinsame Editor-Einstellungen und
  Extension-Empfehlungen
- `dna/LICENSE` — das MIT-Lizenz-Template (Variablen
  `dnaCopyrightHolder`, `dnaCopyrightYear`)
- `dna/doc/` — die kanonischen Entwickler-Guides (Ticket-Workflow
  `develop.md`, Install-Guides, Org-Guides)
- `dna/scripts/` — Node-Skripte für die Repo-Verwaltung
- `dna/_vars.json` — die Basis-Variablen-Defaults (`company`,
  `copyrightHolder`, `gitOrgUrl`, `projectName`, …)

## Verwendung

Als Dev-Dependency deklarieren und einmalig initialisieren:

```bash
pnpm add -D dna_base        # TypeScript projects
dart pub add dev:dna_base   # Dart projects
gg_dna init
```

Der platzierte Test instanziiert und verifiziert die DNA bei jedem
Testlauf. Ökosystem-Layer
([dna_dart](https://github.com/ggsuite/dna_dart),
[dna-ts](https://github.com/tssuite/dna-ts)) bauen auf diesem Paket
auf — Konsumenten hängen üblicherweise von diesen ab statt direkt von
dna_base.

## Entwicklung

Dieses Repo hat `role: "dna"` in `.gg/dna.json`: Der `dna/`-Ordner
wird von Hand gepflegt, nie generiert. Das Repo instanziiert seine
eigene DNA — nach Änderungen `dart test` ausführen; vorher committen
(eine Datei, die die DNA überschreiben würde, darf keine
uncommitteten Änderungen tragen).
