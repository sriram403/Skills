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

## 2. Layout

```
Skills/
├── README.md                  catalog of skills (what each is for, when to use it)
├── AGENTS.md / CLAUDE.md      this protocol
├── CHANGELOG.md               every change to the library: date, what, from which project
├── global/GLOBAL_INSTRUCTIONS.md   the block installed into ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md
├── scripts/install.ps1        links skills + installs the global block (idempotent)
├── templates/SKILL.md         skeleton for a new skill
└── skills/<name>/
    ├── SKILL.md               frontmatter (name, description) + the skill, kept under ~500 lines
    └── references/*.md        optional detail, loaded only when SKILL.md points to it
```

Domain skills (`game-dev`, `3d-modelling`, ...) hold that domain's general knowledge. Cross-cutting
skills (`first-principles-solving`, `research`, `testing-and-verification`, `project-memory`) hold what
every domain shares. A domain skill keeps a **short, domain-worded version** of a cross-cutting idea
and links to the full skill: e.g. `3d-modelling` has "Elon's algorithm applied to likeness" in a few
lines and points to `first-principles-solving` for the method.

## 3. How to add what a project taught

Only after the user said yes to generalizing (see the global rules).

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
- Long detail (engine APIs, parameter tables) goes in `references/`, linked from `SKILL.md`.

## 5. Defaults the user has shown across projects (confirm per project)

- Ask when unsure; give a recommended answer with each question; A / B choices read best.
- Propose before building a loosely described thing, with your own ideas marked S1, S2, ...
- Plain-language reports: what was done, what wasn't tested, what's next. Honest about failures.
- Keep everything a project needs inside its own folder (on D:, not C:), downloads in their own folder.
- Free / open-source tools and assets unless the user says otherwise.
- Real-world time is the scarcest resource: size every check to the change.
- Notes are the memory: a new thread must be able to continue from the files alone.
