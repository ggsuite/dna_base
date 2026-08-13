<!--
@license
Copyright (c) dnaCopyrightHolder

Use of this source code is governed by terms that can be
found in the LICENSE file in the root of this package.
-->

# Publish-Guide

Wie dnaCompany-Pakete veröffentlicht werden. Publishen läuft über `gg`
und ist bewusst der am stärksten abgesicherte Schritt im Workflow.

## Grundregeln

- **`gg do publish` wird nur von einem Menschen ausgelöst** — nie von
  einem Agenten, auch nicht "hilfsbereit" nach grünem Review.
- Publish verweigert, wenn der aktuelle Ticket-Stand nicht reviewt
  ist (`gg did review`). Commits nach dem letzten Review erfordern
  ein neues `gg do review` — siehe [Review-Guide](./review-guide.md).
- Vorher prüfen mit `gg can publish` (führt standardmäßig `pana` aus;
  `--no-pana` überspringt es).

## Was Publish macht

```bash
gg do publish            # ticket workspace: all repos in dependency order
gg one do publish        # standalone repo
```

Pro Repo: Version erhöhen (gemäß konfiguriertem Increment), Merge via
**Auto-Merge-Pull-Request** (Default; `--no-pr` merged lokal und
pusht direkt), in die Registry publizieren (pub.dev und/oder npm —
Hybrid-Pakete in beide), Versions-Tag anlegen und pushen, und den
Remote-Feature-Branch löschen (Default).

Nützliche Flags (aus `gg do publish -h` — die Hilfe ist die
Wahrheit):

- `--merge-only` — das Ticket mergen ohne Release (kein Versions-Bump,
  kein Tag); `--force` erlaubt das trotz lokaler Refs.
- `--continue` — einen fehlgeschlagenen Publish dort fortsetzen, wo er
  stehen blieb.
- `--restart` — den gespeicherten Lauf-Zustand verwerfen und neu
  konfigurieren (`--continue` ist nicht mit `--config` oder
  `--restart` kombinierbar).
- `--publish-unchanged` — jedes Repo publizieren, auch unveränderte.
- `--channel stable|rc` (Einzel-Repo) — `rc` publiziert das nächste
  `X.Y.Z-rc.N`-Prerelease statt eines stabilen Release.

## Die Publish-Config (`.gg/`)

Zwei Dateien pro Repo, bewusst getrennt:

- **`.gg/publish_config.json`** — die **Eingaben**, camelCase,
  eingepackt in einen `publishConfig`-Root-Key. **Das ist die Datei,
  die die KI während der Arbeit pflegt:**
  - `mergeMessage` — Pull-Request-Titel und Merge-Commit-Message,
    initialisiert aus der Ticket-Beschreibung.
  - `versionIncrement` — `patch` | `minor` | `major`.
  - `nextCommitMessage` — der Vorschlag, den das nächste
    `gg do commit` anzeigt; die KI hält ihn synchron mit dem, was
    gerade uncommitted ist.
  - `commits` — die Messages der Commits, die dieses Ticket bereits
    gemacht hat, geschrieben von `gg do commit` (nie von Hand); wird
    als Pull-Request-Beschreibung gerendert.
- **`.gg/publish_state.json`** — der **Lauf-Fortschritt** (Status,
  erledigte Schritte, Branch, Channel, …). Wird von `gg do publish`
  während des Laufs geschrieben; `--continue` setzt darauf auf,
  `--restart` verwirft ihn. Nie von Hand editieren.

## Legacy: `.gg-publish.json`

Die alte Einzel-Config-Datei (snake_case: `version_increment`,
`merge_message`, `channel`, `delete_ticket`, `delete_feature_branch`,
`pr`, plus Per-Repo-Overrides unter `repos.<name>`) ist **Read-only-
Legacy**: `--config path/to/.gg-publish.json` akzeptiert sie weiterhin
für Headless-Läufe, und eine liegengebliebene Datei hält ein
laufendes Ticket fortsetzbar — aber gg schreibt dieses Format nie
wieder. Fehlende Pflichtfelder brechen den Lauf ab; es gibt keinen
stillen Prompt-Fallback.

## Vor dem Publishen

- **Ein Blog-Post für das aktuelle Ticket ist angelegt** — Blog-Posts
  werden immer als Teil des Publishens geschrieben, in beiden Sprachen
  unter `doc/blog/<en|de>/<yyyy>/<yyyy>-<MM>-<dd>-<topic>.md`. Siehe
  [Blog-Guide](./blog-guide.md).
- `CHANGELOG.md` spiegelt das Release (automatisch gepflegt von
  `gg do commit`, siehe [Documentation-Guide](./doc-guide.md)).
- README und Beispiel passen zur publizierten API — siehe
  [README-Guide](./readme-guide.md) und
  [Example-Guide](./example-guide.md).
- Für pub.dev-Pakete: `pana` läuft standardmäßig als Teil von
  `gg can publish` — grün halten.
