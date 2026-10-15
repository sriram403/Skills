---
name: project-memory
description: How to keep a project's notes so any new thread or any model (Claude, GPT/Codex, others) can continue instantly, and so lessons survive between projects - the hand-off file with a LIVE STATUS, the mistake log (assumed → reality → fix → habit), lessons written the moment they happen, AGENTS.md and CLAUDE.md kept in step, "update the md files", milestone check-ins, short threads, and promoting general lessons to the user's skills library. Use when starting or setting up any multi-session project, when the user says "update the md files", "hand over", "new thread", "write it down", "note this", or at a milestone.
---

# Project memory: notes that let any model carry on

**Version: v1 (2026-10-15).** From the Finding Naresh game and the Ellie 3D build, where the notes
were what let a new thread (or another model) continue with no loss.

**You may ask the user questions at any point**, e.g. which notes they want for a small project, or
whether to continue in this thread or a new one. If you're sure, go ahead.

## 1. Why

Models don't learn while they work and threads end without warning (compaction drops detail by
chance; a long thread gets slow and costly, since every message resends the whole conversation).
**The files are the memory.** At every moment they must let a brand-new thread, or another model,
continue: what was done, how (methods, commands), what was learned, and the exact next action.
Nothing important may live only in the chat.

## 2. The files (start small; add only what the project needs)

| File | What's in it | When it changes |
|---|---|---|
| `AGENTS.md` | Instructions for every model: how to work here, the read order, the user's rules for this project, the list of notes. Codex/GPT read this name. | When a rule changes |
| `CLAUDE.md` | `@AGENTS.md` plus anything Claude-only. Keep the two in step (or import, so there's one copy). | With AGENTS.md |
| `HANDOFF.md` (or `notes/MASTER_PROMPT.md`) | Read order + **LIVE STATUS**: where work stopped, the exact next action, commands to run | After every sub-step |
| `notes/TODO.md` or `PROGRESS.md` | Live checklist: a "Right now" line on top, `[~]` in progress, sub-steps ticked with results (pass/fail, numbers) | As each piece lands |
| `notes/LESSONS.md` / `LEARNINGS.md` | Sorted lessons: what happened, why, what to do instead; tool gotchas; environment facts | The moment you learn one |
| Mistake log (a section in the rough notes or lessons) | **assumed → reality → fix → habit** | The moment reality disagrees |
| `notes/PRINCIPLES.md` / `PRO_WORKFLOW.md` | How work is done here, the method versions (v1, v2, ...) and a decision log (date, decision, on whose observation) | When the method changes |
| `notes/CHANGE_LEDGER.md` | Each change: what changed, what it could break, which tests cover it | As each change lands |
| `notes/POLISH.md` | Things agreed "for later"; remind the user at the end | When the user defers something |

Templates: [`templates/`](templates/) (AGENTS.md, HANDOFF.md, LESSONS.md).

## 3. Habits

- **Write at once, read first.** Lessons and mistakes go in the moment they happen, not at the end of
  a milestone. Before starting something similar, read the mistake log: writing is half, reading
  first is the other half.
- **"Update the md files"** means every note the change touches, without being told which. Keep that
  list in the project's `AGENTS.md` so any model can find it.
- **Before editing, look:** at the start of a thread, read the hand-off and run `git status`; the last
  thread may have left work half done.
- **Say where a thing lives:** which folder and branch hold a part. Nothing is "ready" until it's in
  the copy the user runs.
- **Commit small and often** (locally); push only per the project's rules or when the user asks.
- **Short threads with good notes beat one long thread.** At a natural break (a milestone), update all
  notes, then either continue here (if this thread's context really matters) or hand over to a new
  thread whose first instruction is "read `HANDOFF.md` first and follow it". If unsure, ask the user
  once: "continue here, or a new thread?" Some apps let you create the next-thread task yourself;
  if so, do that and tell the user in one line.
- **Notes before the context fills:** if a thread is getting long, write everything worthwhile into
  the files before a compaction.
- **Reports** at a hand-off, in plain language: (a) what couldn't be tested, (b) what's done, (c) the
  next step.

## 4. Promoting lessons to the skills library

Project notes keep project lessons. Lessons that would help a *different* project belong in the
user's library at `D:\mine\Agentics\Skills`.
- While working, mark such lessons as general (e.g. a "General" tag or a short list at the end of
  `LESSONS.md`).
- At a milestone or the end of the work, **ask the user**: "Is it okay to generalize these into your
  skills library?" with the lessons one line each.
- On a yes, follow `D:\mine\Agentics\Skills\AGENTS.md`: right skill, generalized wording, merged
  rather than appended, changelog line.
