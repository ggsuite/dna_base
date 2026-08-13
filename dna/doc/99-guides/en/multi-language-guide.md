<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Multi-Language Guide

Documentation exists in **two languages: English (`en`) and German
(`de`)**. Both are first-class — neither is "the translation that lags
behind".

## What exists in both languages

- **README:** `README.md` (English) and `README.de.md` (German), side
  by side in the repo root.
- **Guides:** `doc/99-guides/en/` and `doc/99-guides/de/` — same file
  names in both folders.
- **Blog posts:** `doc/blog/en/<yyyy>/` and `doc/blog/de/<yyyy>/` —
  same file names in both trees (see the
  [Blog Guide](./blog-guide.md)).

File names stay **identical** in both trees (English names); only the
content is translated. The README is the exception with its `.de.md`
suffix, because both variants live in the same folder.

## The sync rule

`en` and `de` are mirrors:

- Every file has a counterpart with the same name in the other
  language.
- **When a `de` file changes, the corresponding `en` file is updated
  in the same change — and vice versa.** The two languages never
  drift apart.
- A file without its counterpart, or a change that touches only one
  language, is a review finding.

## Division of labor for AI

As an AI you **always edit the `en` files by default**, then adapt the
corresponding `de` files afterwards — never the other way around. Only
when the user explicitly works on a `de` file does the flow reverse:
then the `en` counterpart is updated right after.

## Translation rules

- **Content-equal, not word-for-word.** The two versions say the same
  thing; idiomatic phrasing beats literal translation.
- **Untranslated stay:** commands, code blocks, file paths, API names,
  and established technical terms. A German sentence around
  `gg do commit` is fine; a translated command is not.
- **Structure-equal:** same headings (translated), same order, same
  examples — so readers can switch languages mid-document without
  getting lost.
