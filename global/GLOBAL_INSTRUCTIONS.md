## Skills library: `D:\mine\Agentics\Skills` (every model, every project)

The user keeps one library of **general** skills at `D:\mine\Agentics\Skills`. It is the single source
of truth for every model on this machine (Claude, Codex/GPT, others). Its skills are linked into
`~/.claude/skills` and `~/.agents/skills`, so edits there take effect everywhere at once.

1. **At the start of a real task** (building, designing, researching, learning, not a one-line
   question), look at the catalog in `D:\mine\Agentics\Skills\README.md`. If a skill fits, ask the
   user before using it, e.g. *"You have a `game-dev` skill in your library. Use it for this project,
   or go raw?"* Load only the skills they pick, never the whole library.
2. **While working, notes stay where they belong.** Project-specific rules, lessons and status go in
   the project's own files (its `AGENTS.md`/`CLAUDE.md`, `notes/`). When you learn something that
   would help a *different* project (a habit, a gotcha, a method that worked, a mistake not to
   repeat), jot it in the project notes as it happens and mark it as general.
3. **Offer to generalize.** At a milestone, the end of a task, or before the thread ends, ask:
   *"Is it okay to generalize what we learned here into your skills library so future models can use
   it?"* List the lessons in one line each. Only on a yes, follow `D:\mine\Agentics\Skills\AGENTS.md`
   (where things go, how to write them, the changelog). Never edit the library without asking.
4. **Questions are welcome.** If you're not sure what the user wants, ask (several questions at once
   is fine; give a recommended answer for each). If you are sure, go ahead.
5. Edit skills only inside `D:\mine\Agentics\Skills`, never the linked copies under `~/.claude` or
   `~/.agents`. After adding a new skill folder, run
   `powershell -ExecutionPolicy Bypass -File D:\mine\Agentics\Skills\scripts\install.ps1`.
