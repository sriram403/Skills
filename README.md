# Skills

Reusable skills and agent instructions.

## Layout

```
skills/                         Skills in the SKILL.md format (frontmatter: name, description)
  first-principles-solving/     How to solve any problem: core problem first, versioned ideas
  learning-skill/               Build an interactive learning app for any topic or source material
project-guides/
  finding-naresh/               Agent instructions from the Finding Naresh game project
    CLAUDE.md                   Instructions for Claude
    AGENTS.md                   Same instructions for other models (GPT, Codex, ...)
    notes/PRINCIPLES.md         How the work is done: first principles, "the algorithm"
    notes/LESSONS.md            What to do and not do when building with AI models
    notes/TESTING_METHOD.md     The testing method, version by version
    notes/MASTER_PROMPT.md      Resume prompt for continuing the project
```

Paths inside the project guides (e.g. `notes/TODO.md`, `DESIGN.md`) refer to the
original game repository and are kept as written.

## Installing a skill

Copy a skill folder into `~/.claude/skills/` (user-wide) or `.claude/skills/`
(per project):

```sh
cp -r skills/first-principles-solving ~/.claude/skills/
```
