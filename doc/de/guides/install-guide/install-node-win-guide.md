<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Node auf Windows installieren

- [Node deinstallieren](#node-deinstallieren)
  - [Cache leeren](#cache-leeren)
  - [Uninstaller ausführen](#uninstaller-ausführen)
  - [Verbliebene Node-Ordner entfernen](#verbliebene-node-ordner-entfernen)
  - [Node-Pfad aus der PATH-Variable entfernen](#node-pfad-aus-der-path-variable-entfernen)
- [NVM installieren](#nvm-installieren)
- [Node über NVM installieren](#node-über-nvm-installieren)

## Node deinstallieren

Wir verwenden `nvm`, um Node-Versionen zu installieren und
auszuwählen. Falls `nvm` bereits installiert ist, kannst du diesen und
den nächsten Schritt überspringen.

### Cache leeren

[Microsoft](https://learn.microsoft.com/en-us/windows/dev-environment/javascript/nodejs-on-windows#install-nvm-windows-nodejs-and-npm)

```bash
npm cache clean --force
```

### Uninstaller ausführen

Drücke `Windows`

Tippe `uninstall Node.js`

Klicke `Uninstall Node.js`

Folge den Anweisungen

### Verbliebene Node-Ordner entfernen

[Verbliebene Node-Ordner entfernen](https://stackoverflow.com/questions/20711240/how-to-completely-remove-node-js-from-windows)

### Node-Pfad aus der PATH-Variable entfernen

Entferne Node aus der PATH-Variable:

Drücke `Windows`

Tippe `environment`

Klicke `Edit the system environment variables`

Klicke `Environment Variables`

Wähle in der `oberen Box` `PATH`

Klicke `Edit`

Suche den Node-Pfad

Falls vorhanden, entferne den Eintrag

Schließe den Dialog

## NVM installieren

[Quelle](https://github.com/coreybutler/nvm-windows#installation--upgrades)

Öffne <https://github.com/coreybutler/nvm-windows/releases>

Lade `nvm-setup.exe` herunter

Führe `nvm-setup.exe` aus

Folge den Anweisungen

## Node über NVM installieren

Drücke `Windows`

Tippe `cmd` und drücke `Enter`

```bash
nvm install lts
nvm use lts
```
