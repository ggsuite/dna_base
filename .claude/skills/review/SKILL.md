---
name: review
description: Runs a complete review of the current branch by executing the review guide (doc/99-guides/en/review-guide.md) end to end - scope, tooling checks, review checklist, standardized report, interactive fix loop. The guide is the single source of truth for the procedure; this skill only adds the interaction rules. Use this skill when the user says something like "review", "check my branch", "is this mergeable", "code review", "pruefe meinen Branch", or "check before merging".
---

# Review (guide-driven)

You run a complete review of the current branch. The procedure is
**not** defined here: it is defined in the review guide, and you
execute it end to end.

## Procedure

1. Read `doc/99-guides/en/review-guide.md` and follow its five phases
   in order: **scope → tooling → checklist → report → fix loop** —
   including the scope message, the report template and the
   classification (blocker / suggestion / nit) defined there.
2. When this skill and the guide disagree, **the guide wins** — report
   the mismatch so the skill can be updated.
3. If the guide is missing, say so and stop; do not improvise a
   review procedure.

## Interaction rules (this skill's only own content)

- **Every step that touches files is confirmed individually** before
  it happens — tooling fixes in phase 1 and patches in phase 4 via
  apply / skip / edit (`edit` = the user describes an alternative,
  you propose a new patch).
- **Write reports and prompts in the language the user is using.**
- **Respect skips:** when the user excludes phases ("only phase 2"),
  follow that and note it at the top of the report.
- **Never** commit, push, or close tickets on your own; commit
  proposals are shown and confirmed explicitly.
- **Never** report a check as fixed without having rerun it.
