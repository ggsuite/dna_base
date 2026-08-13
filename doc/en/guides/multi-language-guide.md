<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Multi-Language Guide

Documentation exists in English (`en`) and German (`de`); both are
first-class.

## Layout

- README: `README.md` (en) and `README.de.md` (de) in the repo root.
- Guides: `doc/en/guides/` and `doc/de/guides/`.
- Blog posts: `doc/en/blog/<yyyy>/` and `doc/de/blog/<yyyy>/` (see the
  [Blog Guide](./blog-guide.md)).

File names are identical in both trees (English names); only the
README differs via its `.de.md` suffix.

## Rules

- `en` and `de` are mirrors: every file has a same-named counterpart,
  and a change to one language updates the other in the same change.
- AI default: edit `en` first, then adapt `de`. Only when the user
  works on a `de` file is the order reversed.
- Translate content- and structure-equal (same headings, order,
  examples), not word-for-word. Commands, code, paths, and API names
  stay untranslated.
- A missing counterpart or a one-language-only change is a review
  finding.
