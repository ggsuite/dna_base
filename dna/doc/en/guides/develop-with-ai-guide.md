<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Start CLAUDE (instruction for the human developer)

## Prepare

[Install required software](./install-guide.md)

[Prepare a gg workspace](./install-guide/install-gg-workspace-guide.md)

## Open CLAUDE

```bash
claude
```

Give CLAUDE the instruction for implementing a ticket.

# CLAUDE: Working instruction (after entering the task)

## CLAUDE: Create a ticket

```bash
cd ~/dev/ # workspace
gg do create ticket dnaJiraPrefix-145 -m"Fix issue abc"
cd tickets/dnaJiraPrefix-145
```

## CLAUDE: Add git repositories

Make a plan for how you roughly want to implement the ticket.
Look at the index.md of each repo in .ocean and decide which repos
need to be added to the ticket.
If certain parts of the implementation belong to a domain that does not
yet exist in the .ocean folder, consider creating a new repository.
Ask the user about this. Also explain to the user what you roughly want
to change in which repo to implement the ticket and let them confirm
that the corresponding repos are added to the ticket.

After the user's confirmation, add the repos to the ticket:

```bash
gg do add repo1 repo2
```

## CLAUDE: Open the workspace in Vscode

```bash
gg do code
```

## CLAUDE: Implement

Implement your features based on the guides

## CLAUDE: Commit

```bash
gg do commit
```

## CLAUDE: Push

```bash
gg do push
```

## CLAUDE: Review

Let the user confirm that the review phase is started.

```bash
gg do review
```

gg creates pull requests for each repo and prints the URLs to the
terminal.

Afterwards load the review-light skill and execute it.

## CLAUDE: Publish

- Create a blog post for the current ticket
- Update the index.md and README.md
- Create the configuration for gg do publish

Ask the user to run the following command **manually**:

```bash
gg do publish
```

gg triggers the pull request merge and publishes the changes to the
registry. Finally the version tag is created and pushed.
