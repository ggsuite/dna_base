<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# DNA Guide

## Prepare your dart project

Not a dart project? Skip this.

### Add helix, the DNA engine

Switch into your projects root folder.

```bash
cd ~/dev/<PROJECT>
```

Add `helix`, the DNA engine as development dependency

```bash
dart pub add helix --dev
```

### Add a DNA

Add a `DNA` repo, e.g. our `dna_base` as dev dependency:

```bash
dart pub add dna_base --dev
```

### Install the DNA update script

DNA is updated on each test run.

Create a `test/dna/dna_test.dart`:

```bash
mkdir test/dna
touch test/dna/dna_test.dart
code test/dna/dna_test.dart
```

Paste the following code:

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

Save.

### Initialize the DNA

Run tests

```bash
dart test
```

## Check, if DNA was installed

`dna_base` adds docs, scripts, configs etc.
Have a look into these:

```bash
cat dna/_vars.json
cat dna/_generated_.json
```

### Configure DNAs

Create a `_dna.json`

```bash
code dna/_dna.json
```

Paste the following code

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

Save

### Install  DNA

Run tests

```bash
dart test
```

### Check generated files

Now the DNA files from `dna_base` are synced into your project

```bash
cat doc/guides/dna-guide.md
```

