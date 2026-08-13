<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Brew auf dem Mac installieren

[Homebrew](https://brew.sh) ist der Paketmanager, mit dem auf dem Mac
die meisten anderen Tools installiert werden, z. B.
[Node](./install-node-mac-guide.md) und
[Flutter](./install-flutter-guide.md).

## Xcode Command Line Tools installieren

Homebrew braucht die Apple Command Line Tools:

```bash
xcode-select --install
```

## Homebrew installieren

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Brew zur Shell-Konfiguration hinzufügen

Auf Apple Silicon wird Homebrew nach `/opt/homebrew` installiert und
ist noch nicht im `PATH`:

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

Auf Intel-Macs wird Homebrew nach `/usr/local` installiert und ist
sofort verfügbar.

## Installation prüfen

```bash
brew --version
```

## Setup prüfen

```bash
brew doctor
```

`Your system is ready to brew.` heißt, alles ist in Ordnung.
Warnungen zu unbeteiligten Paketen können ignoriert werden.

## Brew aktuell halten

```bash
brew update
brew upgrade
```
