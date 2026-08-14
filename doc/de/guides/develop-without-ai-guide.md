<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Entwickeln ohne KI

## Bereite vor

[Benötigte Software installieren](./install-guide.md)

[gg-Workspace vorbereiten](./install-guide/install-gg-workspace-guide.md)

## Lege ein Ticket an

```bash
cd ~/dev/ # workspace
gg do create ticket gGS-145 -m"Fix issue abc"
cd tickets/gGS-145
```

## Füge Git-Repositories hinzu

```bash
gg do add repo1 repo2
```

## Öffne den Workspace

```bash
gg do code
```

## Implementiere

Implementiere deine Features

## Committe

```bash
gg do commit
```

## Pushe

```bash
gg do push
```

## Review

```bash
gg do review
```

gg erstellt Pull Requests für jedes Repo und gibt die URLs im Terminal
aus.

## Publishe

```bash
gg do publish
```

gg stößt den Pull-Request-Merge an und veröffentlicht die Änderungen
in der Registry. Zum Schluss wird der Versions-Tag angelegt und
gepusht.
