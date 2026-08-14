<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Clean Code Guide

- Follow the rules below when creating code

## License Header

- Take over the license header from other files

## General

- Resolve todos and fixmes immediately, otherwise create tickets in Jira etc.
- Do not add project management into the code
- Write open points into [doc/de|en/issues.md](issues.md)
- Start comments with an uppercase letter followed by space and lowercase letters
- Write source code and comments in English

## API documentation

- Document classes and functions with one line, when possible
- Write simple and understandable
- Do not exceed the 80 character limit
- Use the default API doc syntax of the respective language (`///`, `/* ..*/`)
- Document private members inline
- Use 3rd person indicative without naming the function (`Returns ...`)
- Reference other members in the respective language form (e.g. Dart: `[name]`)

## Documentation of functions

- Split functions into blocks of about 3 - 10 lines
- Summarize the content of the block with a one line comment
- Thus allow readers to quickly skim and understand the code
- When it reads well, extract the blocks into a documented function

## Classes and functions

- Separate important functions with `// .......`
- Use one space between `//` and the text
- List the constructors at the beginning
- Place public methods at the top
- Place private methods at the bottom
- Separate public and private methods by a `Private` comment block
- Split methods with more than 5 lines of code into private and public ones
- Comment all public functions

## Example constructors

- Add an `example()` constructor to each class
- It returns a fully preconfigured example instance
- Allow configuring the example via named parameters
- At the end of the constructors

## Example class

Follow `doc/templates/class-template.dart`
