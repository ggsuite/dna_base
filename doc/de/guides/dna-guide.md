<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# DNA-Guide

## Dart-Projekt vorbereiten

Kein Dart-Projekt? Diesen Abschnitt überspringen.

### helix, die DNA-Engine, hinzufügen

Wechsle in den Root-Ordner deines Projekts.

```bash
cd ~/dev/<PROJECT>
```

Füge `helix`, die DNA-Engine, als Development-Dependency hinzu

```bash
dart pub add helix --dev
```

### Eine DNA hinzufügen

Füge ein `DNA`-Repo hinzu, z. B. unser `dna_base`, als
Dev-Dependency:

```bash
dart pub add dna_base --dev
```

### Das DNA-Update-Skript installieren

Die DNA wird bei jedem Testlauf aktualisiert.

Lege eine `test/dna/dna_test.dart` an:

```bash
mkdir test/dna
touch test/dna/dna_test.dart
code test/dna/dna_test.dart
```

Füge folgenden Code ein:

```dart
import 'package:helix/helix.dart';
import 'package:test/test.dart';

void main() {
  test(
    'dna is instantiated and unmodified',
    () => runDnaTest(),
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
```

Speichern.

### Die DNA initialisieren

Tests ausführen

```bash
dart test
```

## Prüfen, ob die DNA installiert wurde

`dna_base` fügt Doku, Skripte, Configs usw. hinzu.
Wirf einen Blick hinein:

```bash
cat dna/_vars.json
cat dna/_generated.json
```

### DNAs konfigurieren

Lege eine `_dna.json` an

```bash
code dna/_dna.json
```

Füge folgenden Code ein

```json
{
  // dna_base is a DNA package: dna/ is authored by hand and is the last
  // layer of its own instantiation. "role": "dna" is also what makes this
  // package usable as a layer at all — a dna/ folder alone does not.
  "version": 1,
  "role": "dna",

  // The root of the tree: everything below gg_dna's own base DNA.
  "layers": ["dna_base"]
}
```

Speichern

### DNA installieren

Tests ausführen

```bash
dart test
```

### Generierte Dateien prüfen

Jetzt sind die DNA-Dateien aus `dna_base` in dein Projekt gesynct

```bash
cat doc/en/guides/dna-guide.md
```
