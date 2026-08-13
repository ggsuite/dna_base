<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# GitHub CLI installieren

Die GitHub CLI (`gh`) wird von unseren Workflow-Skripten verwendet, um
Pull Requests anzulegen, zu mergen und zu beobachten.

## Installation auf dem Mac

Stelle sicher, dass [brew installiert ist](./install-brew-on-mac-guide.md)

```bash
brew install gh
```

## Installation auf Windows

Besuche <https://cli.github.com>

Lade den Installer herunter und führe ihn aus.

Alternativ mit winget installieren:

```bash
winget install --id GitHub.cli
```

## Installation auf Linux / WSL

```bash
sudo apt install gh
```

## Installation prüfen

Starte dein Terminal neu, falls es während der Installation offen war,
und führe aus:

```bash
gh --version
```

Logge dich danach mit `gh auth login` ein.
