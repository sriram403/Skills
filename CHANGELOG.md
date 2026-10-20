# Changelog

Newest first. One line per change: skill, what changed, which project it came from.

## 2026-10-20: the form serves the teaching
- `learning-skill` v2: §0, the user's rule: no default format; pick or invent the form this topic
  needs, crazy ideas welcome, the only test is "complex made easy, intuitive, hands-on" (the user).
  Case study 2: the hands-on blog for a web app, and the habit of checking every picture against its
  note (source: AL Pilot guide).

## 2026-10-20: never fire and forget
- `first-principles-solving` v5: a bug fix that loops (2-3 tries) moves to a test bench, causes tried
  from the most obvious (what's visible) to the least, then the fix goes back (the user).
- Global rules: "note this" is always general; proactive, not conservative (use the skills actively,
  update them yourself, tell the user in one line); lessons go into skills without asking first (the user).
- `testing-and-verification`: debug from pictures (a shot of the stuck moment from a useful
  angle), logs only support (the user).

- `testing-and-verification` v3: watch every run while it runs (check every few seconds against
  the plan, stop at once when it goes off plan), for all testing (the user); the watcher's
  "stands still" rule covers everything that should move and never switches itself off (source:
  Finding Naresh, a stuck van unwatched for 1.5 min).

## 2026-10-16: app skills are private

- `apps/` is git-ignored and has its own local git; its catalog moved to `apps/README.md`. App
  skills are never pushed unless the user asks (the user).

## 2026-10-16: app skills are full records and the base for new projects

- App skills (local) became full records of an app: brief to APK, setup, research, lessons, and
  when to reuse it as a base (the user).
- Global rules + AGENTS.md §1 + README: at the start of every new or existing project, check the
  app skills table; a match is the base (override freely, say what changed); keep an app's
  skill current at each milestone (the user).
- `testing-and-verification` v2: test in the container the user runs (wrapped web apps: real
  injected script + fake native side + tap every button); screenshot toasts while a dialog is open
  (source: Spirit Box app, first phone test).

## 2026-10-16: app skills get their own folder

- New `apps/` folder for app skills (one app's own know-how, not linked globally; the app's
  AGENTS.md/HANDOFF.md point to it). Protocol in AGENTS.md §1, catalog in README, global rules
  mention it (the user).

## 2026-10-16: tell the old thread you moved

- `project-memory` v7 + global rules: every new-thread suggestion warns the user to reply "moved"
  in the old thread; otherwise its timer fires and both threads edit the same files. The new
  thread repeats the reminder in its first reply (hand-off prompt `FIRST:` line) (the user).

## 2026-10-16: real timer before "I'll wait"

- `project-memory` v6 + global rules: start the 3-min timer as a tool call before the new-thread
  message; no timer tool → never claim to wait (the user, after a model promised a wait with no
  timer).

## 2026-10-15: new threads know the skills

- `project-memory` v5 + global rules: the hand-off prompt and HANDOFF.md list the skills in use
  (full paths); a new thread loads them, and any skill the user names ("research X"), without asking
  (the user).

## 2026-10-15: copy-paste hand-off prompt

- Saving first: if a new or existing project has no git/backup, offer to set it up before editing
  (global rules, `project-memory`, README; the user).
- `project-memory` v4: every new-thread suggestion ends with a clear-cut, copy-paste hand-off prompt
  (TASK / DONE / SCOPE / NOW / KEY RULES / CONTEXT) using full absolute paths (the user, from the
  Ellie build hand-offs).

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
