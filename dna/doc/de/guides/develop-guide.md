<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Entwickeln

## Vorbereiten

[Benötigte Software installieren](./install-guide.md)

[gg-Workspace vorbereiten](./install-guide/install-gg-workspace-guide.md)

## Ticket anlegen

```bash
cd ~/dev/ # workspace
gg do create ticket dnaJiraPrefix-145 -m"Fix issue abc"
cd tickets/dnaJiraPrefix-145
```

## Git-Repositories hinzufügen

```bash
gg do add repo1 repo2
```

## Workspace öffnen

```bash
gg do code
```

## Implementieren

Implementiere deine Features

## Committen

```bash
gg do commit
```

## Pushen

```bash
gg do push
```

## Review

```bash
gg do review
```

gg erstellt Pull Requests für jedes Repo und gibt die URLs im Terminal
aus.

## Publishen

```bash
gg do publish
```

gg stößt den Pull-Request-Merge an und veröffentlicht die Änderungen
in der Registry. Zum Schluss wird der Versions-Tag angelegt und
gepusht.
