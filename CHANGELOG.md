# Changelog

Newest first. One line per change: skill, what changed, which project it came from.

## 2026-10-15: friendlier talk, two-strike new-thread rule, own folder per project

- Changing a skill: the agent asks "just this project (its AGENTS.md) or everywhere (the skill)?".
- README rewritten for GitHub visitors (behaviour, changing skills, install); install.ps1 fills in
  the clone's real path, so the library works from any folder.

- Global rules regrouped: talk short and a bit fun, name the skill behind a behaviour, own folder per
  new project + ask about keeping storage inside it, user-created rules go straight into skills.
- `project-memory` v3: suggest a new thread at most twice per thread (3-min wait each), then just
  work; a new thread starts the count fresh; short, fun message template (the user).
- MPG and blender-rel milestone rules now point to `project-memory` §4.

## 2026-10-15: project memory always on; new threads are a recommendation

- Global rule 5: `project-memory` applies to every task bigger than a quick question, without asking.
- `project-memory` v2: §4 new-thread moments: update notes, recommend a new thread with the reason,
  offer to continue, wait 3 minutes, then continue here; stop only when the user asked for it
  ahead of time (the user, after discussing context overfill).
- Attribution: credit AI tools fairly (the user changed the rule).

## 2026-10-15: the library becomes the single source for every model

- Library: `AGENTS.md`/`CLAUDE.md` protocol, `global/GLOBAL_INSTRUCTIONS.md` (ask before using a
  skill, offer to generalize lessons, questions welcome), `scripts/install.ps1` (junctions for Claude
  Code and Codex, global rules into `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`), `templates/SKILL.md`.
- `first-principles-solving` v4: change method when it loops, final result over own metrics,
  measure impressions, no view = not checked, second worked example (from the Ellie 3D build).
- `research` v1 (new): Elon's learning principles applied to research, procedure, web gathering
  techniques (from the Ellie build's reference gathering, the learning-app builds, Finding Naresh).
- `project-memory` v1 (new): hand-off/LIVE STATUS, lessons, mistake log, short threads, promoting
  lessons, note templates (from Finding Naresh and the Ellie build).
- `testing-and-verification` v1 (new): testing method generalized (from Finding Naresh v1–v6,
  Kingsway Pick-Up, the learning-app builds).
- `game-dev` v1 (new): process, design principles, game testing, Godot 4 and Three.js references
  (from Finding Naresh and Kingsway Pick-Up).
- `3d-modelling` v1 (new): working agreement, pipeline with gates, region checklist, Blender/MPFB/hair
  and likeness techniques (from the Ellie TLOU2 build).
- `learning-skill`: links to related skills.
- Removed `project-guides/finding-naresh/` (project copies; the project keeps its own notes, the
  general parts now live in the skills above).

## 2026-10-03 and before

- `first-principles-solving` v1–v3 and `learning-skill` added; Finding Naresh project guide copied in.
