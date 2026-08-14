<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# API Clean Code Guide

## License Header

- Take over the license header from other files

## General

- Resolve todos and fixmes immediately, otherwise create tickets in Jira etc.
- Do not add project management into the code
- Start comments with an uppercase letter followed by lowercase letters
- Write source code and comments in English

## API documentation

- Document classes and functions with one line
- Write simple and understandable
- Compress API documentation
- Do not exceed the 80 character limit
- Use the default API comment of the respective language (`///`, `/* ..*/`)
- Document private members inline
- Use 3rd person indicative without naming the function (`Returns ...`)
- Reference other members in the respective language form (e.g. Dart: `[name]`)

## Documentation of functions

- Split functions into sections of about 3 - 10 lines
- Comment the content of the section with one line of code
- Allow readers to quickly skim and understand the code

## Classes and functions

- Separate important functions with `// .......`
- Use one space between `//` and the text
- List the constructors at the beginning
- Place public methods at the top
- Place private methods at the bottom
- Separate public and private methods by a `Private` comment block
- Split methods with more than 3 lines of code into private and public ones
- Comment all public functions

## Example constructors

- Add an `example()` constructor to each class
- It returns a fully preconfigured example instance
- Allow configuring the example via named parameters

## Example class

```dart
/// Represents a value of Type T in the memory.
class GgValue<T> {
  // ...........................................................................
  /// Sets the value and triggers an update on the stream.
  set value(T newVal) { /* … */ }

  // ######################
  // Private
  // ######################

  // .............
  // Stream

  // ...........................................................................
  T _value;
}
```
