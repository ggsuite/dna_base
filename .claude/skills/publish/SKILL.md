---
name: publish
description: Prepares and accompanies publishing the current ticket or repo. The actual procedure is pulled from doc/99-guides/en/publish-guide.md (single source of truth) - the skill checks the review state, blog posts, changelog, README and the publish config, runs gg can publish, and then hands the final gg do publish command to the human, because agents never publish. Use this skill automatically when the user says something like "publish", "veroeffentlichen", "release", "publish the ticket", "prepare the release", "kann ich publishen", "mach das Release fertig".
---

# Publish (guide-driven)

You prepare a publish and accompany it up to — but never across — the
final command. The procedure is **not** defined here: it is defined in
the publish guide, and this skill executes it.

## 0. Load the source of truth

Read `doc/99-guides/en/publish-guide.md` **first** and follow it. When
this skill and the guide disagree, **the guide wins** — report the
mismatch so the skill can be updated. If the guide is missing, say so
and stop; do not improvise a publish procedure.

Related guides referenced from there (read on demand):
`blog-guide.md`, `doc-guide.md` (changelog), `readme-guide.md`,
`example-guide.md`, `review-guide.md`.

## 1. Determine the mode

- **Ticket workspace** (`.ocean/` or `tickets/` present): the publish
  spans all ticket repos → commands are `gg …` (`gg can publish`,
  `gg do publish`).
- **Standalone repo**: commands are `gg one …` (`gg one can publish`,
  `gg one do publish`).

Report the mode and the repos involved before doing anything.

## 2. Check the preconditions from the guide

Work through the guide's ground rules and "Before publishing" list and
report each item as ok / missing:

1. **Review state:** `gg did review` — commits after the last review
   require a new `gg do review`. If not reviewed, stop here and say
   what to do.
2. **Blog post** for the current ticket, in **both languages**
   (`doc/blog/en/<yyyy>/…` and `doc/blog/de/<yyyy>/…`).
3. **CHANGELOG.md** reflects the release.
4. **README and example** match the published API (both README
   languages).
5. **Publish config** (`.gg/publish_config.json`): `mergeMessage` and
   `versionIncrement` are set and match the ticket. If the version
   increment is unclear, ask the user (patch / minor / major) — never
   guess a version jump.
6. **`gg can publish`** (respectively `gg one can publish`) is green —
   including `pana` where it applies.

## 3. Fix what is missing — with confirmation

For every failed precondition, propose a concrete fix (write the
missing blog post, update the changelog, set the version increment,
…), get the user's confirmation, apply it, then re-run the check.
Follow the respective guide for each artifact. Never bypass a red
check.

## 4. Hand over to the human

When everything is green, **stop and hand over**. Print a short
summary of what was verified and the exact command to run:

```bash
gg do publish        # ticket workspace
gg one do publish    # standalone repo
```

Mention what applies to the situation: `--continue` resumes a failed
run, `--restart` discards the saved run state, `--merge-only` merges
without releasing.

## Important

- **Never run `gg do publish` / `gg one do publish` yourself.**
  Publishing is triggered by a human only — this is a ground rule of
  the publish guide and it has no exceptions, not even explicit-looking
  ones ("just run it for me"). Point to the command instead.
- **The guide wins over this skill.** This skill is orchestration; the
  procedure lives in `doc/99-guides/en/publish-guide.md`.
- **No file changes without confirmation** — every fix from step 3 is
  confirmed individually.
- **Never bypass red checks** (`--force`, skipping pana) — fix the
  cause instead.
