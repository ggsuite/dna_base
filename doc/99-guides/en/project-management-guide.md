<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Project Management Guide

How work is organized at ggsuite: every change happens inside a
**ticket**, and new packages are created with the standard tooling.

## Tickets

There are two ticket modes — pick by scope:

- **Multi-repo ticket** — changes affect several repos, or it is not
  yet clear which repos are needed → ticket in the gg ticket
  workspace.
- **Single-repo ticket** — the bug or feature clearly affects exactly
  one repo → ticket branch directly in the repo.

### Multi-repo ticket

The gg ticket workspace is the folder containing `.ocean/` (legacy
name `.master/`, renamed automatically) and a `tickets/` folder.

```bash
cd <workspace>
gg do ls repos                                  # available repos
gg do create ticket <ticket-id> -m '<description>'
cd tickets/<ticket-id>
gg do add <repo1> <repo2> ...
gg do code                                      # open VS Code workspace
```

- `gg do create ticket` creates `tickets/<ticket-id>/` with a
  `.ticket` file (JSON: ID + description), a VS Code workspace file
  and a trash folder.
- Which repos belong to the ticket is decided by reading the
  `index.md` of the candidate repos (summary, domain, interfaces) —
  see the [Index Guide](./index-guide.md).
- `gg do add` clones the repos into the ticket, checks out the branch
  `<ticket-id>` in each of them and rewires intra-workspace
  dependencies to local paths. Local dependencies of the chosen repos
  are picked up automatically — prefer adding too few repos over too
  many.
- Repo names must match the folder names under `.ocean/` exactly.

### Single-repo ticket

```bash
cd <repo>
git pull            # before creating the ticket, never after
gg one do create ticket <branch-name> -m '<description>'
```

This checks out a new ticket branch and writes a `.ticket` file.
Existing local changes are preserved (stashed and re-applied on the
new branch).

### Ticket naming

- **Ticket ID = branch name.** Short and speaking, in the style of the
  existing tickets: `gGS-123` or `fix_login_crash`.
- **Description:** one or two sentences describing the problem or
  feature; it lands in the `.ticket` file.

## Creating new packages

New packages are created with `gg_create_package` — never by copying
an existing repo or hand-rolling boilerplate.

```bash
gg_create_package -h    # always check current flags first
gg_create_package -n <name> -g <github-org> \
  -d "<description with at least 60 characters>" [--no-open-source]
```

- Run it in the parent folder where the sibling repos live.
- **Package name = repo name = class prefix**, following the team
  prefixes (`gg_`, `kidney_`, `ds_`, …) where they apply.
- The description must be **at least 60 characters**, otherwise
  `gg_create_package` refuses.
- Decide explicitly: GitHub org, open source yes/no, Flutter package
  yes/no.
- `gg_create_package` delivers the standard structure — do not add
  extra boilerplate, CI configs or licenses on top.

After creating: commit locally, then `git push -u origin main`. If the
remote already has commits (pre-created repo with README/LICENSE),
check what is there first and only force-push with `--force-with-lease`
after explicit agreement.

## Day-to-day flow

Implementation, commits, pushes, reviews and publishing are covered in
the [Develop Guide](./develop-guide.md), the
[Review Guide](./review-guide.md) and the
[Publish Guide](./publish-guide.md).
