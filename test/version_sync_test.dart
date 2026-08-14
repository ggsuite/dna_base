// @license
// Copyright (c) ggsuite
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

// Guards the version contract of this hybrid package: pubspec.yaml is the
// source of truth and `dart run scripts/sync_version.dart` copies it into
// package.json. This test fails when the two run out of sync.
@TestOn('vm')
library;

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('package.json', () {
    test('version matches pubspec.yaml', () {
      final match = RegExp(
        r'^version:\s*(\S+)\s*$',
        multiLine: true,
      ).firstMatch(File('pubspec.yaml').readAsStringSync());
      expect(match, isNotNull, reason: 'no version in pubspec.yaml');

      final pkg =
          jsonDecode(File('package.json').readAsStringSync())
              as Map<String, dynamic>;
      expect(
        pkg['version'],
        match!.group(1),
        reason: 'Run "dart run scripts/sync_version.dart".',
      );
    });

    test('ships the dna folder to npm consumers', () {
      final pkg =
          jsonDecode(File('package.json').readAsStringSync())
              as Map<String, dynamic>;
      expect(pkg['files'], contains('dna'));
      expect(pkg['name'], '@tssuite/dna-base');
    });
  });
}
