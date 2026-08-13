<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# CLI Guide

How command line tools are built in ggsuite projects. These rules
are tool-agnostic — they apply to every CLI, in every language,
regardless of which framework it is built with.

## Command tree

- A CLI is a **tree of subcommands**: `<tool> <group> <command>`.
  Groups collect related commands; each command does exactly one
  thing.
- Every command and group has a **one-line description**, shown in the
  help of its parent.
- **Every level answers `-h`/`--help`.** The help is generated from
  the command definitions, so it cannot drift from reality.
- **Help is the source of truth.** Scripts, docs and agents read `-h`
  instead of guessing flags — and the CLI must make that possible.

## Checks before actions

For every command that mutates state, offer a **side-effect-free check
command** ("can this be done?"):

- The check runs the same validations as the action, but changes
  nothing — usable in CI and before long operations.
- The acting command runs the checks anyway and **aborts on red**. A
  `--force` escape hatch may exist, but it is documented as such and
  never the normal path.
- A third kind of command reports state ("has this been done?") so
  users and agents query the tool instead of interpreting internals by
  hand.

## Arguments

- **Named flags with sensible defaults**; required flags are marked as
  required and fail with a clear message when missing.
- **Everything a prompt can ask must also be settable via flag or
  config file.** In non-interactive mode (CI), missing required values
  abort — no silent prompt fallback.
- Validate input at the boundary and fail early with a message that
  names the offending value.

## Output

Output follows a **fixed semantic scheme** — categories, not ad-hoc
colors (Dart reference implementation: `gg_console_colors`):

| Category | Color    | Meaning                                       |
| -------- | -------- | --------------------------------------------- |
| success  | green    | success message                               |
| error    | red      | error message                                 |
| warning  | yellow   | warning                                       |
| action   | yellow   | call to action / instruction to the user      |
| command  | blue     | command the user can run                      |
| path     | blue     | file or directory path                        |
| detail   | darkGray | context that should visually recede           |
| h1       | cyan     | heading, level 1                              |
| h2       | bold     | heading, level 2 (bold — legible on light and dark terminals) |

Fixed patterns:

- **Status lines:** `⌛️ <message>` while running, replaced by
  `✓ <message>` or `✗ <message>` when done. **Only the mark is
  colored**, the message stays neutral. On CI without terminal
  control, each status line is printed anew instead of overwritten.
- **Errors carry the next step:** the message says what failed *and*
  which command to run next, with the command in command color.
- **Suggestions:** prose in action color, embedded commands in command
  color.
- **Details recede:** multi-line context (raw tool output) is printed
  as one dimmed block below the message that carries the colors.

Rules:

- **Color is never the only carrier of information.** Marks (`✓`/`✗`)
  and text must convey the message without color.
- **Respect color deactivation:** `NO_COLOR` set or `TERM=dumb`
  switches colors off automatically. No raw ANSI escape sequences in
  application code.
- **Color sparingly and deliberately:** mark, command, path, detail,
  heading — never fully colored paragraphs.
- **No new color meanings** — the scheme is fixed; extensions go into
  the shared implementation as a new semantic category.

## Exit codes

- `0` on success, non-zero on failure — without exception, so CI and
  scripts can rely on it.
- A failed check command exits non-zero just like a failed action.

## Testability

- **All output goes through an injectable logger**, not `print` —
  only then is output capturable and redirectable in tests.
- **Prompts are injectable callbacks** (`String? Function(String)`),
  so interactive paths are testable without a terminal.
- In tests, strip colors and control characters before comparing
  strings.

## What not to do

- **No** raw ANSI escape sequences in application code.
- **No** prompts as the only way to provide a value — CI must be able
  to pass it via flag or config.
- **No** output via `print` — always through the injectable logger.
- **No** mutating command without a matching side-effect-free check.
- **No** guessing culture: if the help does not document a flag, the
  flag does not exist.
