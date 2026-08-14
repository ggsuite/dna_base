<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Neues ggsuite-Repository anlegen


## Kopiere diese Datei nach tmp

Öffne diese Datei in vscode

Drücke `Cmd + Shift + S`

Gehe in dein Temp-Verzeichnis, z. B. `/tmp`

Speichere die Datei dort.

## Ersetze in diesem Dokument

In der _gesamten_ Datei:

Ersetze `my_new_repo` durch den Namen deines neuen Repos

Ersetze `A 60-70 char description of my new project` durch eine kurze
Projektbeschreibung

## Lege ein Repo an

Öffne <https://github.com/https://github.com/ggsuite>

Wähle `Repositories`

Klicke `New repository`

Trage im Feld `Repository Name` `my_new_repo` ein

Füge im Feld `Description`
`This package allows to track changes and state of git directories`
ein

Klicke auf das Dropdown `Private`. Wähle `Public`

Klicke auf das Dropdown `No template`.

Wähle `gg_template_project` oder `gg_template_with_cli`

Klicke `Create Repository`

## Richte die Branch-Regeln ein

Führe folgendes Skript aus, um die unten gezeigten Branch-Regeln
einzurichten:

```bash
node scripts/setup-github-repo.js
```

Du willst die Änderungen von Hand vornehmen? Dann so:

Öffne <https://github.com/https://github.com/ggsuite/my_new_repo>

Klicke `Settings`

Klicke `Branches`

Suche `Branch Protection Rules`

Klicke `Add branch ruleset`

Trage als `Ruleset Name` `Default` ein

Setze `Enforcement status` auf `Active`

Suche `Branch targeting criteria`

Klicke `Add target`

Wähle `Include default branch`

Aktiviere folgende Einstellungen:

- [x] `Restrict deletions`
- [x] `Require linear history`
- [x] `Require a pull request before merging`
  - Willst du ein Code-Review vor dem Merge verlangen?
    - Nein
      - Behalte die Default-Einstellungen
        - Setze `Required Approvals` auf 0
        - Hake keine der Boxen an
    - Ja
      - Klicke auf das Dropdown unter `Required approvals`
        - Wähle `1` für `Required Approvals`
        - Hake folgende Boxen an:
          - [ ] `Dismiss stale pull request approvals when new commits are pushed`
          - [ ] `Require review from code owners`
          - [x] `Require approval of the most recent reviewable push`
          - [x] `Require conversation resolution before merging`
  - Klicke auf `Allowed merge methods:`
    - Wähle nur `Squash`
- [x] `Require status checks to pass`
  - [x] `Require branches to be up to date before merging`
  - Klicke `Add checks`
  - Gib `Quick` ins Suchfeld ein
  - Wähle die `Quick checks` GitHub Actions
- [x] `Block force pushes`

Klicke `Create`

Authentifiziere dich, wenn du danach gefragt wirst

## Lass Branches nach dem Merge löschen

Öffne <https://github.com/https://github.com/ggsuite/my_new_repo>

Klicke `Settings`

Scrolle hinunter zu `Pull Requests`

Setze folgende Einstellungen:

- [ ] `Allow merge commits`
- [x] `Allow squash merging`
- [ ] `Allow rebase merging`
- [x] `Always suggest updating pull request branches`
- [x] `Allow auto-merge`
- [x] `Automatically delete head branches`

## Checke das neue Projekt aus und öffne es

Checke das Projekt aus

```bash
git clone git@github.com:https://github.com/ggsuite/my_new_repo.git
cd my_new_repo
dart pub upgrade
```

Öffne das Projekt mit vscode

```bash
code .
```

Bereite einen neuen Branch und Pull Request vor

```bash
git checkout -b rename-classes
```

## Benenne template-project in my_new_repo um

### Rufe das Rename-Skript auf

```bash
node scripts/rename-class.js gg_template_project my_new_repo
```

## Passe die pubspec.yaml an

Öffne `pubspec.yaml` und nimm folgende Änderungen vor:

Setze die Version auf `0.0.0` zurück

Setze die Description auf `A 60-70 char description of my new project`

## Committe den initialen Stand

```bash
git add .
git commit -am "Rename template-project into my_new_repo"
```

## Pushe den Branch

Klicke in `vscode` auf der `linken Seite` auf das
`Source Control`-Icon.

### Lege den Pull Request an und schließe ihn ab

```bash
git push --set-upstream origin rename-classes
gh pr create --base main --title "Rename template-project into my_new_repo" --body " "
gh pr merge --auto --squash
node ./scripts/wait-for-pr.js
```

### Lösche den Feature-Branch

```bash
node scripts/delete-feature-branch.js
```

## Veröffentliche das erste Mal auf pub.dev

```bash
dart pub publish
```

Öffne <https://pub.dev/packages/my_new_repo>

Klicke `Admin`

Klicke unter `Select a publisher` auf das `leere Dropdown`

Wähle `Transfer to publisher`

Wähle `inlavigo.com`

Klicke im `erscheinenden Dialog` auf `ok`
