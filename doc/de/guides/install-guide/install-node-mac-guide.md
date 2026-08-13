<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Node auf dem Mac installieren

Stelle sicher, dass [brew installiert ist](./install-brew-on-mac-guide.md)

## nvm mit Homebrew installieren

```bash
brew install nvm
```

## nvm-Verzeichnis anlegen (falls nicht automatisch angelegt)

```bash
mkdir ~/.nvm
```

## nvm zur Shell-Konfiguration hinzufügen

Füge folgende Zeilen zu deiner `~/.zshrc` hinzu:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"
```

## Änderungen anwenden

```bash
source ~/.zshrc
```

## Installation prüfen

```bash
command -v nvm
```

## Node installieren

```bash
nvm install lts
nvm use lts
```
