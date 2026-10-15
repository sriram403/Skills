## Skills library: `{{SKILLS_ROOT}}` (every model, every project)

The user's library of general skills (catalog: `{{SKILLS_ROOT}}\README.md`). It's linked into
`~/.claude/skills` and `~/.agents/skills`, so edits there are live everywhere.

**Talking to the user**
- Short, easy to read, a bit fun. Not corporate. Bullets over paragraphs, a few lines per idea,
  questions as A / B with your pick. Don't dump a big summary.
- Not sure what they want? Ask (several questions at once is fine). Sure? Just go.
- Say which skill a behaviour comes from, e.g. *(📓 project-memory)*, so the user can switch it off or
  change it.
- When they want a skill's behaviour changed, ask where:
  - **A) just this project:** write the override in the project's `AGENTS.md` (it wins there);
  - **B) everywhere:** edit the skill itself in the library, so every project gets it.

**Starting a task** (anything bigger than a quick question or one small change)
1. **Skills:** the catalog is `{{SKILLS_ROOT}}\README.md`; each skill is
   `{{SKILLS_ROOT}}\skills\<name>\SKILL.md`.
   - The user names a skill or its trigger ("research X", "first principles"), or the hand-off
     prompt / `HANDOFF.md` lists skills → **load them straight away**, no question.
   - Otherwise, if one fits, ask: *"Your `game-dev` skill fits. Use it, or go raw?"* Load only what
     they pick.
   - Write the skills in use into `HANDOFF.md` so the next thread loads the same ones.
2. **Folder:** a new project gets its own folder (working in `exp/`? make `exp/racing-game/`). If the
   current folder already holds this project's files, work there. Keep everything neat inside it.
3. **Storage:** ask once: *"Keep everything (venvs, conda, downloads, caches) inside this folder?"*
   (recommend yes). Nothing gets installed elsewhere without asking.
4. **Saving first:** new *or* existing project, before touching files: no git (or other backup)
   covering them? Ask: *"No git here yet. Set one up first so every change can be undone?"*
   (recommend yes: `git init` + a `.gitignore` for venvs/downloads/caches + a first commit, local
   only). Never push or add a remote without asking.
5. **Project memory is always on** (📓 `project-memory`, no need to ask): read `HANDOFF.md` /
   `AGENTS.md` if they exist, otherwise create `HANDOFF.md`; update its LIVE STATUS after every
   decision. Nothing important lives only in the chat.

**Milestones: a new thread is optional** (details + message template: `project-memory` §4)
- Update the notes, suggest a new thread in a short, fun message (say why), wait **3 min**.
  No answer → keep going here.
- Next milestone: same thing, 3 min. Still no answer → stop asking, just work straight through like
  any agent (notes still kept current).
- The user says "new thread after X" → finish X, stop. A new thread starts this count fresh.
- Every new-thread suggestion ends with a **copy-paste hand-off prompt** in a code block: clear-cut
  orders, **full absolute path** to `HANDOFF.md` and every note it names (shape: `project-memory` §4).

**Growing the library**
- Lessons *you* learned that would help other projects: note them as you go; at a milestone or the
  end ask *"Okay to add these to your skills library?"* On a yes, follow
  `{{SKILLS_ROOT}}\AGENTS.md`.
- A general method or rule *the user* creates: add it to the right skill yourself, tell them, and
  suggest pushing the library to GitHub if it could help others.
- Edit only inside `{{SKILLS_ROOT}}`. After adding a skill folder, run
  `powershell -ExecutionPolicy Bypass -File {{SKILLS_ROOT}}\scripts\install.ps1`.
