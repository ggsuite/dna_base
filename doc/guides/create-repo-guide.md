<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Create a new ggsuite repository

## Content <!-- omit in toc -->

- [Create a new ggsuite repository](#create-a-new-dnagitorg-repository)
  - [Copy this file to tmp](#copy-this-file-to-tmp)
  - [Replace in this doc](#replace-in-this-doc)
  - [Create repo](#create-repo)
  - [Setup branch rules](#setup-branch-rules)
  - [Require deleting branches after merge](#require-deleting-branches-after-merge)
  - [Checkout and open the new project](#checkout-and-open-the-new-project)
  - [Rename template-project into my\_new\_repo](#rename-template-project-into-my_new_repo)
    - [Call rename script](#call-rename-script)
  - [Edit pubspec.yaml](#edit-pubspecyaml)
  - [Commit the initial state](#commit-the-initial-state)
  - [Push branch](#push-branch)
    - [Create and complete pull request](#create-and-complete-pull-request)
    - [Delete feature branch](#delete-feature-branch)
  - [Publish the first time to publdev](#publish-the-first-time-to-publdev)

## Copy this file to tmp

Open this file in vscode

Press `Cmd + Shift + S`

Go to your temp dir, e.g. `/tmp`

Save the file there.

## Replace in this doc

In the _whole_ file:

Replace `my_new_repo` by the name of your new repo

Replace `A 60-70 char description of my new project` by a short project description

## Create repo

Open <https://github.com/https://github.com/ggsuite>

Select `Repositories`

Click `New repository`

In the field `Repository Name`, enter `my_new_repo`

Into the `Description` field, paste
`This package allows to track changes and state of git directories`

Click the dropdown `Private`. Select `Public`

Click the dropdown `No template`.

Select `gg_template_project` or `gg_template_with_cli`

Click `Create Repository`


## Setup branch rules

Open <https://github.com/https://github.com/ggsuite/my_new_repo>

Click `Settings`

Click `Branches`

Locate `Branch Protection Rules`

Click `Add branch ruleset`

As `Ruleset Name` enter `Default`

Set `Enforcement status` to `Active`

Locate `Branch targeting criteria`

Click `Add target`

Select `Include default branch`

Check the following settings:

- [x] `Restrict deletions`
- [x] `Require linear history`
- [x] `Require a pull request before merging`
  - You want to require a code review before merging?
    - No
      - Keep the default settings
        - Set `Required Approvals` to 0
        - Don't check any off the boxes
    - Yes
      - Click on the dropdown below `Required approvals`
        - Select `1` for `Required Approvals`
        - Check the following boxes:
          - [ ] `Dismiss stale pull request approvals when new commits are pushed`
          - [ ] `Require review from code owners`
          - [x] `Require approval of the most recent reviewable push`
          - [x] `Require conversation resolution before merging`
  - Click on `Allowed merge methods:`
    - Only select `Squash`
- [x] `Require status checks to pass`
  - [x] `Require branches to be up to date before merging`
  - Click `Add checks`
  - Enter `Quick` into the search field
  - Select `Quick checks` GitHub Actions
- [x] `Block force pushes`

Click `Create`

When asked, Authenticate

## Require deleting branches after merge

Open <https://github.com/https://github.com/ggsuite/my_new_repo>

Click `Settings`

Scroll down to `Pull Requests`

Apply the following settings:

- [ ] `Allow merge commits`
- [x] `Allow squash merging`
- [ ] `Allow rebase merging`
- [x] `Always suggest updating pull request branches`
- [x] `Allow auto-merge`
- [x] `Automatically delete head branches`

## Checkout and open the new project

Checkout the project

```bash
git clone git@github.com:https://github.com/ggsuite/my_new_repo.git
cd my_new_repo
dart pub upgrade
```

Open project with vscode

```bash
code .
```

Prepare a new branch and pull request

```bash
git checkout -b rename-classes
```

## Rename template-project into my_new_repo

### Call rename script

```bash
node scripts/rename-class.js gg_template_project my_new_repo
```

## Edit pubspec.yaml

Open `pubspec.yaml` and add the following changes:

Reset version to `0.0.0`

Set description to-70 `A 60 char description of my new project`

## Commit the initial state

```bash
git add .
git commit -am "Rename template-project into my_new_repo"
```

## Push branch

In `vscode` at the `left side`, click `Source Control` icon.

### Create and complete pull request

```bash
git push --set-upstream origin rename-classes
gh pr create --base main --title "Rename template-project into my_new_repo" --body " "
gh pr merge --auto --squash
node ./scripts/wait-for-pr.js
```

### Delete feature branch

```bash
node scripts/delete-feature-branch.js
```

## Publish the first time to publdev

```bash
dart pub publish
```

Open <https://pub.dev/packages/my_new_repo>

Click `Admin`

Below `Select a publisher`, click on the `empty dropdown`

Select `Transfer to publisher`

Select `inlavigo.com`

On the `appearing dialog`, click `ok`

