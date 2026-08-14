<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# API Clean Code Guide

- Beachte die folgenden Regeln beim Erstellen von Code

## License Header

- Übernimm den License Header aus anderen Dateien

## Allgemein

- Erledige Todos, FixMes sofort, falls nicht lege Tickets in Jira etc. an
- Füge kein Project-Management im Code hinzu
- Beginne Kommentare mit Großbuchstaben gefolgt von Kleinbuchstaben
- Verfasse Quellcode und Kommentare in Englisch

## API-Dokumentationen

- Dokumentiere Klassen und Funktionen mit einer Zeile
- Schreibe einfach und verständlich
- Komprimiere Api-Dokumentationen
- Überschreite nicht das 80 Zeichen Limit
- Verwende den Default API Kommentar der jeweiligen Sprache (`///`, `/* ..*/`)
- Dokumentiere private Member inline
- Verwende 3rd-Person-Indikativ ohne Nennung des Funktionsnamen (`Returns ...`)
- Referenziere andere Member in der jeweiligen Sprach-Form (z.B. Dart: `[name]`)

## Dokumentation von Funktionen

- Teile Funktionen in Abschnitte von ca. 3 - 10 Zeilen ein
- Kommentiere den Inhalt des Abschnitts mit einer Zeile Code
- Ermögliche Lesern, den Code schnell überfliegen und verstehen zu können

## Klassen und Funktionen

- Trenne wichtige Funktionen mit `// .......`
- Verwende ein Leerzeichen zwischen `//` und Text
- Liste die Konstruktoren am Anfang
- Platziere öffentliche Methoden oben
- Platziere private Methoden unten
- Trenne öffentliche und private Methode durch einen `Private` Kommentarblock
- Teile methoden mit mehr als 3 Zeilen Code in private und öffentliche
- Kommentiere alle öffentlichen Funktionen

## Example Konstruktoren

- Füge zu jeder Klasse einen `example()` Konstruktor
- Dieser liefert ein voll vorkonfigurierte Beispiel-Instanz
- Ermögliche, das Example über benannte Parameter zu konfigurieren

## Beispiel-Klasse

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
