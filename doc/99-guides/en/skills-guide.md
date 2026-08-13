<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Skills Guide

How Claude Code skills are shipped and written in ggsuite repos.
Skills are packaged instructions that Claude Code loads for a specific
kind of task. The DNA distributes them via `dna/dot-claude/skills/`,
which is instantiated into `.claude/skills/` of every consuming repo.

## Shipped skills

| Skill         | Purpose                                                        |
| ------------- | -------------------------------------------------------------- |
| `init`        | Create a DNA-aware `CLAUDE.md` (+ `dna/_override/PROJECT_STRUCTURE.md`) for the repo |
| `new-project` | Create a new package/repository with `gg_create_package`       |
| `new-ticket`  | Create a multi-repo or single-repo ticket via `gg`             |
| `publish`     | Prepare a publish per the publish guide; the final `gg do publish` stays human-triggered |
| `review`      | Execute the review guide end to end: scope, tooling, checklist, report, fix loop |

## Anatomy of a skill

One folder per skill containing a `SKILL.md`:

```text
dot-claude/skills/<skill-name>/SKILL.md
```

`SKILL.md` starts with YAML frontmatter:

```markdown
---
name: <skill-name>
description: <what it does + when to trigger it>
---

# <Title>

<instructions for the agent>
```

- **`name`** matches the folder name.
- **`description`** carries two things: what the skill does, and the
  **trigger phrases** ("use this skill automatically when the user
  says …"). The description is what the agent sees when deciding
  whether to invoke the skill — invest in it.
- The **body** is written as direct instructions to the agent,
  imperative, with numbered steps in the order they must happen.

## Rules for writing skills

Extracted from the shipped skills — follow them in new ones:

- **Confirmation before side effects.** Every step that creates,
  changes or deletes something is announced and confirmed by the user
  first. Steps that only read may run freely.
- **Never guess flags or paths.** Run `-h` first (`gg_create_package
  -h`, `gg -h`) and construct calls from the help output. Paths that
  differ per machine (workspace root, repo parent folder) are asked
  for or discovered by searching — never hardcoded.
- **Degrade gracefully.** If a tool is missing (`gg` not installed),
  report it and continue or stop — never mock results.
- **Don't over-ask.** When the user already provided a name, branch or
  repo list, do not re-ask — only clarify the missing parts and
  confirm once at the end.
- **End with a wrap-up.** Report what was created where (absolute
  paths) and suggest next steps — but do not execute them unasked.
- **State the hard "never" rules** in a final "Important" section:
  never push unasked, never publish, never invent content.

## Skill vs. guide

- **Guides** (`doc/99-guides/`) define how to work in the repo. They
  are imported through the managed CLAUDE.md block, so they are
  always loaded — see the
  [DNA Design Guide](./dna-design-guide.md).
- **Skills** describe how to execute a concrete workflow step by step
  — they load on demand.

When the two overlap, keep them consistent: a workflow change lands
in the guide first, then in the skill that automates it.
