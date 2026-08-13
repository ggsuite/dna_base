<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Flutter installieren

Flutter bringt das Dart SDK mit. Mit der Flutter-Installation bekommst
du also auch `dart`, das für die Installation von
[gg](./install-gg-guide.md) gebraucht wird.

## Installation auf dem Mac

Stelle sicher, dass [brew installiert ist](./install-brew-on-mac-guide.md)

```bash
brew install --cask flutter
```

## Installation auf Windows

Lade das Installations-Bundle herunter von
<https://docs.flutter.dev/get-started/install/windows>

Entpacke es in einen Ordner ohne Leerzeichen, z. B. `C:\src\flutter`

Füge `C:\src\flutter\bin` zu deiner `Path`-Umgebungsvariable hinzu:

Drücke `Windows`, tippe `environment variables`, öffne
`Edit the system environment variables`, klicke
`Environment Variables`, wähle `Path`, klicke `Edit` und füge den
Ordner hinzu.

Starte dein Terminal neu.

## Installation auf Linux / WSL

Stelle auf Windows sicher, dass WSL und Ubuntu installiert sind

```bash
sudo apt install -y git curl unzip xz-utils zip libglu1-mesa
git clone https://github.com/flutter/flutter.git -b stable ~/flutter
```

Füge Flutter zu deiner Shell-Konfiguration hinzu:

```bash
echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

## Installation prüfen

```bash
flutter --version
dart --version
```

## Setup prüfen

```bash
flutter doctor
```

Folge den Anweisungen von `flutter doctor`, bis alle Einträge, die du
brauchst, einen Haken haben. Einträge für Plattformen, für die du
nicht entwickelst (z. B. Android Studio oder Xcode), können ignoriert
werden.
