// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

/// The base DNA of our projects.
///
/// The payload of this package is its `dna/` folder — the DNA that
/// [gg_dna](https://github.com/ggsuite/gg_dna) instantiates into every
/// consuming repository. Dart code only exposes the package version, so
/// consumers can report which DNA they inherit from.
library;

export 'src/dna_base_version.dart';
