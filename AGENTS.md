# Skills library: instructions for every model (Claude, Codex/GPT, others)

`CLAUDE.md` in this folder only points here, so there is one copy of these rules.

This folder is the user's single library of **general** skills: ways of working, methods and
gotchas that help on *any* project. Every model on this machine reads it through links
(`~/.claude/skills/<name>`, `~/.agents/skills/<name>` → `skills/<name>`), so a change here is live
everywhere. The short rules every model follows in every project are in
[`global/GLOBAL_INSTRUCTIONS.md`](global/GLOBAL_INSTRUCTIONS.md); this file is the long version, for
when you are about to change the library.

## 1. What belongs here, and what doesn't

| Belongs here (general) | Stays in the project |
|---|---|
| A habit that would have saved time on a different project | Status, TODOs, milestones, hand-off notes |
| A method that worked, with the versions it went through | Rules only that project needs (its folders, branches, scripts) |
| A tool or engine gotcha (Godot, Three.js, Blender, shell, Windows) | Design of that game/model/app (characters, levels, puzzles) |
| How the user likes to work (asking, proposals, reports) | Numbers and names that only mean something there |

**Test:** would this help a model starting a *different* project tomorrow? Yes → library.
Project names may stay as **examples** ("in a co-op game, ...", "e.g. the Ellie face build"), never
as the rule itself.

**App skills (`apps/<app>/SKILL.md`)** are the exception, by the user's choice (2026-10-16). Each is
the **full record of one app that was built**: what it is, the architecture, how it was built on PC
and phone, research facts, tests, every lesson, and the ship checklist. They exist so the next similar
project starts from something that worked ("check the apps skills we already have and see if
anything matches what we're building today"). Rules:
- Named after the app (`apps/spirit-box`). §0 of each says **when to use it as a base**: a table of
  "if the new project has… → reuse…". The table in `apps/README.md` gives a one-line match hint per app.
- **Private, local only** (the user, 2026-10-16): `apps/` is in `.gitignore` here and has its **own
  local git** (`apps/.git`). Commit app changes there. Never push it, add a remote to it, or copy an
  app skill into the public repo unless the user asks. Before pushing this library, check that
  `git ls-files apps` is empty.
- At the start of every new or existing project, models check that table (global rules, step 1). Use a
  matching app as the base, override freely, and tell the user which parts were reused or changed.
- Not linked into `~/.claude/skills` / `~/.agents/skills` (they'd crowd every project's skill list);
  models find them through `apps/README.md`. The app's own `AGENTS.md`/`HANDOFF.md` name it by full path.
- The first lines say which project folder it belongs to; paths inside are relative to that folder.
- Long parts go in `references/` (build-log, research, platform setup, lessons).
- Keep it current at each milestone of that app. A lesson that would help *other* apps too goes into
  the matching general skill (after the user says yes), and the app skill keeps a one-line pointer.
- Status, TODOs and hand-off notes still stay in the project.

## 2. Layout

```
Skills/
├── README.md                  catalog of skills (what each is for, when to use it)
├── AGENTS.md / CLAUDE.md      this protocol
├── CHANGELOG.md               every change to the library: date, what, from which project
├── global/GLOBAL_INSTRUCTIONS.md   the block installed into ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md
├── scripts/install.ps1        links skills + installs the global block (idempotent)
├── templates/SKILL.md         skeleton for a new skill
├── skills/<name>/
│   ├── SKILL.md               frontmatter (name, description) + the skill, kept under ~500 lines
│   └── references/*.md        optional detail, loaded only when SKILL.md points to it
└── apps/<app>/SKILL.md        app skills: one app's own know-how (not linked globally; see §1)
```

Domain skills (`game-dev`, `3d-modelling`, ...) hold that domain's general knowledge. Cross-cutting
skills (`first-principles-solving`, `research`, `testing-and-verification`, `project-memory`) hold what
every domain shares. A domain skill keeps a **short, domain-worded version** of a cross-cutting idea
and links to the full skill: e.g. `3d-modelling` has "Elon's algorithm applied to likeness" in a few
lines and points to `first-principles-solving` for the method.

## 3. How to add what a project taught

Lessons a model learned: only after the user said yes to generalizing. A general method or rule the
user created: add it right away, tell them, and suggest pushing (the repo is public on GitHub).

1. **Pick the home.** Find the skill whose description fits; if it fits two, write it in the
   cross-cutting one and add a one-line pointer in the domain one. A new skill only when nothing fits
   *and* there are several lessons for it (one lesson is a line in an existing skill).
2. **Generalize the wording.** State the habit first, then the example that taught it:
   *assumed → reality → fix → habit* for mistakes. Cut project names, paths and numbers that don't
   transfer; keep numbers that do (an engine limit, a timing, a parameter that worked).
3. **Merge, don't append.** Read the skill first. If the lesson is already there, sharpen that line
   or add the new example; don't add a near-duplicate. Delete lines that turned out to be wrong.
4. **Version and log.** Bump the skill's `Version:` line when its method changes, and add one line to
   `CHANGELOG.md` (date, skill, what, source project).
5. **Keep the catalog in step:** a new skill or a changed purpose → update the table in `README.md`.
6. **New skill folder:** copy `templates/SKILL.md`, then run
   `powershell -ExecutionPolicy Bypass -File scripts\install.ps1` so Claude and Codex see it.
7. **Git:** commit with a plain message. Push only when the user asks. Credit the AI tool that helped
   (e.g. a `Co-Authored-By` trailer), truthfully (the user's global rule).

## 4. Writing a skill

- **Frontmatter:** only `name` (lowercase, digits, hyphens, = folder name) and `description` (what it
  is + when to use it, with the words the user would say; under 1024 characters). Both Claude and
  Codex read exactly these two fields.
- **Plain, short sentences.** The user is not a professional developer in every field; write so a
  new model *and* the user can follow it.
- **Rules carry their reason** (who asked, what went wrong without it).
- **Every skill says the model may ask the user questions** when unsure about what they want, and
  should go ahead when sure.
- **Example messages to the user** in a skill are short, bulleted and a bit fun (see
  `project-memory` §4), never a wall of text.
- Long detail (engine APIs, parameter tables) goes in `references/`, linked from `SKILL.md`.

## 5. Defaults the user has shown across projects (confirm per project)

- Messages short, easy to read and a bit fun, not corporate; say which skill a behaviour comes from.
- Ask when unsure; give a recommended answer with each question; A / B choices read best.
- Each new project in its own folder; ask once whether everything (venvs, downloads) stays inside it.
- No git (or backup) on the files? Offer to set it up before the first edit.
- Propose before building a loosely described thing, with your own ideas marked S1, S2, ...
- Plain-language reports: what was done, what wasn't tested, what's next. Honest about failures.
- Keep everything a project needs inside its own folder (on D:, not C:), downloads in their own folder.
- Free / open-source tools and assets unless the user says otherwise.
- Real-world time is the scarcest resource: size every check to the change.
- Notes are the memory: a new thread must be able to continue from the files alone.
