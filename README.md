# Skills

The user's library of **general** skills: how they like work done, methods that proved themselves,
and tool gotchas, written so any model (Claude, Codex/GPT, others) can use them on any project.
Project-specific notes stay in each project; what transfers is generalized into this folder.

**Models:** read [AGENTS.md](AGENTS.md) before changing anything here. The short rules every model
follows on every project are in [global/GLOBAL_INSTRUCTIONS.md](global/GLOBAL_INSTRUCTIONS.md).

## Catalog

| Skill | Use it for |
|---|---|
| [first-principles-solving](skills/first-principles-solving/SKILL.md) | Any "how should we do X" problem: core problem first, Elon's algorithm, versioned ideas, change method when it loops, the mistake log |
| [research](skills/research/SKILL.md) | Researching or learning anything fast: framing, primary sources, many references, solid vs uncertain, smallest experiment; web gathering (images, video frames, downloads) |
| [learning-skill](skills/learning-skill/SKILL.md) | Building an interactive learning app that teaches the user a topic or source material end to end |
| [project-memory](skills/project-memory/SKILL.md) | Notes that let any thread or model continue: hand-off + LIVE STATUS, lessons, mistake log, "update the md files", promoting lessons to this library |
| [testing-and-verification](skills/testing-and-verification/SKILL.md) | Proving a change works: checks that can fail, testing like the user, test sized to the change, watched runs, change ledger, videos |
| [game-dev](skills/game-dev/SKILL.md) | Making games (Godot, Three.js/web): design and proposals, realistic and lived-in worlds, play-test bots, dev menus, engine gotchas |
| [3d-modelling](skills/3d-modelling/SKILL.md) | Blender + Python modelling and character likeness with free tools: pipeline with gates, grey-clay checks, landmark/camera/hair fitting |

## Layout

```
Skills/
├── README.md                     this catalog
├── AGENTS.md, CLAUDE.md          how models maintain the library (CLAUDE.md imports AGENTS.md)
├── CHANGELOG.md                  every change: date, skill, what, source project
├── global/
│   └── GLOBAL_INSTRUCTIONS.md    installed into ~/.claude/CLAUDE.md and ~/.codex/AGENTS.md
├── scripts/
│   └── install.ps1               links the skills for Claude and Codex, installs the global rules
├── templates/
│   └── SKILL.md                  skeleton for a new skill
└── skills/
    └── <name>/
        ├── SKILL.md              frontmatter (name, description) + the skill
        ├── references/           detail loaded only when needed
        └── templates/            files a skill hands out (e.g. project-memory's note templates)
```

## Install (once per machine, and after adding a skill)

```powershell
powershell -ExecutionPolicy Bypass -File D:\mine\Agentics\Skills\scripts\install.ps1
```

It is safe to run again. It:
1. links every `skills/<name>` into `~/.claude/skills/<name>` (Claude Code) and
   `~/.agents/skills/<name>` (Codex) as directory junctions, so edits here are live everywhere;
2. writes the global rules between `<!-- skills-library:start -->` and `<!-- skills-library:end -->`
   in `~/.claude/CLAUDE.md` (Claude) and `~/.codex/AGENTS.md` (Codex/GPT), keeping the rest of each file.

Other tools: point them at `global/GLOBAL_INSTRUCTIONS.md` and the `skills/` folder (most agents read
`AGENTS.md` and `SKILL.md` files).
