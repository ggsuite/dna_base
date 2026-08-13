<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Example-Guide

Wie Beispiele mit ggsuite-Paketen ausgeliefert werden. Jedes Paket
hat einen `example/`-Ordner, der den Happy Path zeigt.

## Dart-Pakete

- Eine Datei: `example/<pkg>_example.dart`.
- Lauffähig per `dart run example/<pkg>_example.dart`.
- Optionaler Shebang: `#!/usr/bin/env dart`.

## Flutter-Pakete

- `example/` ist ein vollständiges Flutter-Subprojekt:
  - `example/lib/main.dart`
  - `example/pubspec.yaml`
  - `example/test/`

## Regeln

- **Lizenz-Header** auch in Beispielen — eine Beispiel-Datei ist eine
  normale Source-Datei.
- **Funktional vollständig:** Das Beispiel zeigt den Happy Path
  inklusive Setup. Kein "TODO: implement".
- Das Beispiel importiert das Paket über seine **Public API**
  (`package:<pkg>/<pkg>.dart`), nie über `src/`.
- Das Beispiel minimal halten: Eine Datei, die ein Leser in wenigen
  Minuten ausführen und verstehen kann, schlägt eine zweite Demo-App.
- README-Usage-Schnipsel und Beispiel dürfen nicht auseinanderlaufen —
  ändert sich die API, beides aktualisieren.
