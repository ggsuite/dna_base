<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# CLI-Guide

Wie Kommandozeilen-Tools in ggsuite-Projekten gebaut werden. Diese
Regeln sind werkzeug-neutral — sie gelten für jedes CLI, in jeder
Sprache, unabhängig vom Framework.

## Kommandobaum

- Ein CLI ist ein **Baum aus Subcommands**: `<tool> <group> <command>`.
  Gruppen sammeln verwandte Kommandos; jedes Kommando tut genau eine
  Sache.
- Jedes Kommando und jede Gruppe hat eine **einzeilige Beschreibung**,
  sichtbar in der Hilfe des Eltern-Kommandos.
- **Jede Ebene beantwortet `-h`/`--help`.** Die Hilfe wird aus den
  Kommando-Definitionen generiert und kann daher nicht von der
  Realität abweichen.
- **Die Hilfe ist die Wahrheitsquelle.** Skripte, Doku und Agenten
  lesen `-h` statt Flags zu raten — und das CLI muss das möglich
  machen.

## Checks vor Aktionen

Zu jedem Kommando, das Zustand verändert, gehört ein
**seiteneffektfreies Check-Kommando** ("geht das?"):

- Der Check führt dieselben Validierungen aus wie die Aktion, ändert
  aber nichts — nutzbar in CI und vor langen Operationen.
- Das ausführende Kommando führt die Checks ohnehin aus und **bricht
  bei Rot ab**. Eine `--force`-Notluke darf existieren, ist aber als
  solche dokumentiert und nie der Normalfall.
- Eine dritte Kommando-Art meldet Zustand ("wurde das getan?"), damit
  Nutzer und Agenten das Tool fragen, statt Interna von Hand zu
  interpretieren.

## Argumente

- **Benannte Flags mit sinnvollen Defaults**; Pflicht-Flags sind als
  solche markiert und scheitern mit klarer Meldung, wenn sie fehlen.
- **Alles, was ein Prompt abfragen kann, muss auch per Flag oder
  Config-Datei setzbar sein.** Im nicht-interaktiven Modus (CI)
  brechen fehlende Pflichtwerte ab — kein stiller Prompt-Fallback.
- Eingaben an der Grenze validieren und früh scheitern, mit einer
  Meldung, die den fehlerhaften Wert benennt.

## Ausgabe

Ausgaben folgen einem **festen semantischen Schema** — Kategorien
statt Ad-hoc-Farben (Dart-Referenz-Implementierung:
`gg_console_colors`):

| Kategorie | Farbe    | Bedeutung                                     |
| --------- | -------- | --------------------------------------------- |
| success   | grün     | Erfolgsmeldung                                |
| error     | rot      | Fehlermeldung                                 |
| warning   | gelb     | Warnung                                       |
| action    | gelb     | Handlungsaufforderung / Instruktion           |
| command   | blau     | Kommando, das der Nutzer ausführen kann       |
| path      | blau     | Datei- oder Verzeichnispfad                   |
| detail    | darkGray | Kontext, der visuell zurücktreten soll        |
| h1        | cyan     | Überschrift, Ebene 1                          |
| h2        | bold     | Überschrift, Ebene 2 (bold — lesbar auf hellen und dunklen Terminals) |

Feste Muster:

- **Statuszeilen:** `⌛️ <message>` während der Ausführung, ersetzt
  durch `✓ <message>` oder `✗ <message>` am Ende. **Nur das Mark ist
  gefärbt**, die Message bleibt neutral. Auf CI ohne
  Terminal-Steuerung wird jede Statuszeile neu gedruckt statt
  überschrieben.
- **Fehler tragen den nächsten Schritt:** Die Meldung sagt, was
  fehlschlug *und* welches Kommando als Nächstes zu laufen hat — das
  Kommando in Command-Farbe.
- **Suggestions:** Prosa in Action-Farbe, eingebettete Kommandos in
  Command-Farbe.
- **Details treten zurück:** Mehrzeiliger Kontext (rohe Tool-Ausgabe)
  wird als ein gedimmter Block unter der Meldung gedruckt, die die
  Farben trägt.

Regeln:

- **Farbe ist nie der einzige Informationsträger.** Marks (`✓`/`✗`)
  und Text müssen die Aussage auch ohne Farbe transportieren.
- **Farb-Deaktivierung respektieren:** `NO_COLOR` gesetzt oder
  `TERM=dumb` schaltet Farben automatisch ab. Keine rohen
  ANSI-Escape-Sequenzen im Anwendungscode.
- **Farbe sparsam und gezielt:** Mark, Kommando, Pfad, Detail,
  Überschrift — nie komplett durchgefärbte Absätze.
- **Keine neuen Farb-Bedeutungen** — das Schema ist fix; Erweiterungen
  gehören als neue semantische Kategorie in die geteilte
  Implementierung.

## Exit-Codes

- `0` bei Erfolg, ungleich 0 bei Fehler — ausnahmslos, damit CI und
  Skripte sich darauf verlassen können.
- Ein fehlgeschlagener Check endet genauso mit ungleich 0 wie eine
  fehlgeschlagene Aktion.

## Testbarkeit

- **Alle Ausgaben laufen über einen injizierbaren Logger**, nicht über
  `print` — nur dann ist Output in Tests abfangbar und umleitbar.
- **Prompts sind injizierbare Callbacks** (`String? Function(String)`),
  damit interaktive Pfade ohne Terminal testbar sind.
- In Tests Farben und Steuerzeichen entfernen, bevor Strings
  verglichen werden.

## Was nicht zu tun ist

- **Keine** rohen ANSI-Escape-Sequenzen im Anwendungscode.
- **Keine** Prompts als einziger Weg, einen Wert zu übergeben — CI
  muss ihn per Flag oder Config setzen können.
- **Keine** Ausgabe via `print` — immer über den injizierbaren Logger.
- **Kein** mutierendes Kommando ohne passendes seiteneffektfreies
  Check-Kommando.
- **Keine** Rate-Kultur: Wenn die Hilfe ein Flag nicht dokumentiert,
  existiert das Flag nicht.
