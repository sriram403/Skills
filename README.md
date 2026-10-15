# Skills

A library of **general skills for AI coding agents** (Claude Code, Codex/GPT, and anything that reads
`AGENTS.md` / `SKILL.md`). They're the working habits, methods and tool gotchas learned on real
projects (games, 3D characters, learning apps), written so they help on *any* project.

One folder, every agent: install it once and every new thread on your machine, in any app, follows
the same rules and can use the same skills. Project-specific notes stay in each project; whatever
transfers gets generalized back into this library.

## Catalog

| Skill | Use it for |
|---|---|
| [first-principles-solving](skills/first-principles-solving/SKILL.md) | Any "how should we do X" problem: core problem first, Elon's algorithm, versioned ideas, change method when it loops, the mistake log |
| [research](skills/research/SKILL.md) | Researching or learning anything fast: framing, primary sources, many references, solid vs uncertain, smallest experiment; web gathering (images, video frames, downloads) |
| [learning-skill](skills/learning-skill/SKILL.md) | Building an interactive learning app that teaches you a topic or source material end to end |
| [project-memory](skills/project-memory/SKILL.md) | Notes that let any thread or model continue: hand-off + LIVE STATUS, lessons, mistake log, new-thread suggestions (**always on**) |
| [testing-and-verification](skills/testing-and-verification/SKILL.md) | Proving a change works: checks that can fail, testing like the user, test sized to the change, watched runs, change ledger, videos |
| [game-dev](skills/game-dev/SKILL.md) | Making games (Godot, Three.js/web): design and proposals, realistic and lived-in worlds, play-test bots, dev menus, engine gotchas |
| [3d-modelling](skills/3d-modelling/SKILL.md) | Blender + Python modelling and character likeness with free tools: pipeline with gates, grey-clay checks, landmark/camera/hair fitting |

## What your agents will do after installing

**When you start something**
- 🧰 **Skill check:** if a skill fits, the agent asks: *"Your `game-dev` skill fits. Use it, or go raw?"*
- 📁 **Own folder:** a new project gets its own folder (`exp/racing-game/`); an existing project
  folder is reused.
- 📦 **Storage:** it asks once whether venvs, conda, downloads and caches stay inside that folder.
- 📓 **Notes from minute one:** `HANDOFF.md` with a LIVE STATUS, updated after every decision, so
  nothing important lives only in the chat.

**While working**
- 💬 Short, readable, slightly fun messages. Questions come as A / B with its pick.
- 🙋 Asks when it's unsure what you want; just goes when it's sure.
- 🏷️ Tags behaviour with the skill it comes from, e.g. *(📓 project-memory)*.

**At milestones**
- 🏁 Saves the notes and *suggests* a fresh thread (old chat = slower, pricier replies), then waits 3 min.
- No answer → keeps going. Second milestone: same. Still no answer → stops asking and just builds.
- Say *"new thread after X"* and it finishes X and stops.
- 📋 Every suggestion ends with a **ready-to-paste prompt** (TASK / DONE / NOW / KEY RULES / CONTEXT)
  with full paths to `HANDOFF.md` and the notes, so the new thread starts right away.

**Growing the library**
- 🧠 Lessons the agent learned: it asks *"Okay to add these to your skills library?"* before writing.
- ✍️ Rules or methods **you** create: added to the right skill straight away, with a nudge to push.

## Changing how a skill behaves

Don't like something? Tell the agent. It asks where the change should go:

| Option | Where it's written | Affects |
|---|---|---|
| **A) Just this project** | the project's own `AGENTS.md` (an override that wins there) | only that project |
| **B) Everywhere** | the skill's `SKILL.md` in this library | every project, every agent |

You can also edit any `SKILL.md` by hand; changes are live at once.

## Install

Windows (PowerShell). Clone anywhere, then run the installer:

```powershell
git clone https://github.com/sriram403/Skills.git
powershell -ExecutionPolicy Bypass -File Skills\scripts\install.ps1
```

It's safe to run again (it only changes what's out of date). It:
1. links each `skills/<name>` into `~/.claude/skills` (Claude Code) and `~/.agents/skills` (Codex) as
   directory junctions, so edits in the library are live everywhere;
2. writes the global rules from [global/GLOBAL_INSTRUCTIONS.md](global/GLOBAL_INSTRUCTIONS.md) into
   `~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md`, between `skills-library` markers, with your clone's
   real path filled in. The rest of those files is left alone.

Folders already in the way are moved to `~/.claude/skills-backup/`, never deleted. Run it again after
adding a new skill folder (agents do this themselves when they add one).

Other agents: point them at `global/GLOBAL_INSTRUCTIONS.md` and the `skills/` folder.

## Layout

```
Skills/
├── README.md                     this page
├── AGENTS.md, CLAUDE.md          how agents maintain the library (CLAUDE.md imports AGENTS.md)
├── CHANGELOG.md                  every change: date, skill, what, source project
├── global/GLOBAL_INSTRUCTIONS.md the always-on rules (installed into each agent's global file)
├── scripts/install.ps1           links skills + installs the global rules
├── templates/SKILL.md            skeleton for a new skill
└── skills/<name>/
    ├── SKILL.md                  frontmatter (name, description) + the skill
    ├── references/               detail loaded only when needed
    └── templates/                files a skill hands out
```

## Contributing a skill

Read [AGENTS.md](AGENTS.md): what counts as general, where a lesson goes, how to write it, and the
changelog line. Start from [templates/SKILL.md](templates/SKILL.md).
