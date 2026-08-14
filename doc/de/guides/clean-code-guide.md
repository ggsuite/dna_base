<!--
@license
Copyright (c) ggsuite

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Clean Code Guide

- Beachte die folgenden Regeln beim Erstellen von Code

## License Header

- Übernimm den License Header aus anderen Dateien

## Allgemein

- Erledige Todos, FixMes sofort, falls nicht lege Tickets in Jira etc. an
- Füge kein Project-Management im Code hinzu
- Schreibe offene Punkte in [doc/de|en/issues.md](issues.md)
- Beginne Kommentare mit Großbuchstaben gefolgt von Space und Kleinbuchstaben
- Verfasse Quellcode und Kommentare in Englisch

## API-Dokumentationen

- Dokumentiere Klassen und Funktionen mit einer Zeile, wenn möglich
- Schreibe einfach und verständlich
- Überschreite nicht das 80 Zeichen Limit
- Verwende den Default API Doc Syntax der jeweiligen Sprache (`///`, `/* ..*/`)
- Dokumentiere private Member inline
- Verwende 3rd-Person-Indikativ ohne Nennung des Funktionsnamen (`Returns ...`)
- Referenziere andere Member in der jeweiligen Sprach-Form (z.B. Dart: `[name]`)

## Dokumentation von Funktionen

- Teile Funktionen in Blöcke von ca. 3 - 10 Zeilen ein
- Fasse den Inhalt des Blocks mit einem einzeiligen Kommentar zusammen
- Ermögliche damit Lesern, den Code schnell überfliegen und verstehen zu können
- Wenn gut lesbar, lagere die Blöcke in eine dokumentierte Funktion aus

## Klassen und Funktionen

- Trenne wichtige Funktionen mit `// .......`
- Verwende ein Leerzeichen zwischen `//` und Text
- Liste die Konstruktoren am Anfang
- Platziere öffentliche Methoden oben
- Platziere private Methoden unten
- Trenne öffentliche und private Methode durch einen `Private` Kommentarblock
- Teile Methoden mit mehr als 5 Zeilen Code in private und öffentliche auf
- Kommentiere alle öffentlichen Funktionen

## Example Konstruktoren

- Füge zu jeder Klasse einen `example()` Konstruktor
- Dieser liefert ein voll vorkonfigurierte Beispiel-Instanz
- Ermögliche, das Example über benannte Parameter zu konfigurieren
- Am Ende der Konstruktoren

## Beispiel-Klasse

Orientiere Dich an `doc/templates/class-template.dart`
