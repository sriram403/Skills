---
name: first-principles-solving
description: How the user wants any problem solved: find the core problem (ask when unsure), break it to what is measurably true, keep every idea as a numbered version (where we started, what each wasted, what we landed on), and work on it in parallel with the main task. Use for any process, design or "how should we do X" question, or when the user says "first principles", "Elon's algorithm", or points at this file.
---

# First-principles solving

**Version: v2 (2026-10-02; v1 the same day without section 5).** Written from the user's own words while testing a
game (Finding Naresh); meant for any model and any problem, not just games.

## 1. What the user wants, in short

- **Find the core problem first.** Restate it in one line: what is actually
  scarce, what is actually wanted. If you can't, *ask the user* what the core
  is: a solution to the wrong core is the most expensive mistake.
- **Break it down to what is true**, measured, tested, in the code, not what
  is usual or assumed. Never accept a limit you haven't tested; run the
  smallest experiment that answers it.
- **Then the algorithm, in order:** question every requirement (who asked for
  it, and why?), delete what isn't needed, simplify what's left, speed up the
  cycle, automate last.
- **Real-world time is the scarcest resource.** More than tokens or machine
  time. Count where the wall-clock time actually goes and cut the biggest part.
- **Think like a detective:** an unexplained result is a clue, not a pass;
  look at the evidence (logs, screenshots, numbers) before theorising, and
  check your own tools before blaming the system under test.

## 2. The procedure

1. **State the core** in one line, with what it costs today (time, money,
   attention). If unsure, ask: "Is the core problem X?"
2. **Break the cost down** into its parts (where does the time go?). Measure
   them if you can.
3. **Write v1 as it is today**, then each better idea as v2, v3, ...: what it
   keeps, what it still wastes, and why the next version exists (who saw
   what). Never delete an old version: the path is part of the lesson.
4. **Pick one and say why**: name the waste it removes. Mark it "proposed"
   until the user agrees.
5. **Check with the user while other work goes on.** Don't stop the main
   task to wait; tell them the pick and the open questions, keep working.
   - If they say it's not solved, the core you had in mind isn't theirs:
     drill into the question ("What does solved look like to you?") rather
     than polishing the wrong answer.
   - If they want to think it through themselves, let them; don't spend more
     on it in the meantime.
6. **Keep the document versioned**: the version on top, a decision log at
   the bottom (what changed, when, on whose observation).
7. **Feedback both ways:** the user's ideas aren't always right either, and
   they want to hear a better one. Say so plainly, with the reason.

## 3. The worked example (testing a game, 2026-10-02)

Full file: `D:\mine\Agentics\T3_Code_Works\MPG\notes\TESTING_METHOD.md`.

- **Core:** least wall-clock time until a test sheet is proven blind.
- **Where the time went:** the game doing the steps; dead runs carrying on;
  the model's think time between steps; rerunning steps that had passed.
- **v1** scripted runs judged at the end: a dead run carried on for minutes.
- **v2** fail fast: stops, but a fix means starting over.
- **v3** one command at a time, live: found many real bugs, but the model
  checked *every* step, so the game idled during its think time.
- **v4** the watched run: the script plays on; a watcher checks each step's
  expected outcome and the always-true rules in parallel; stop only on a
  failure; fix; resume from that step from a save point. Model time goes
  only on failures.
- What made v4 visible: asking "what would a human tester do?" The human
  plays on and only stops when something that should have happened didn't.

## 4. Remember mistakes (simulated learning)

Models don't learn while they work: the weights don't change, so the same
mistake comes back on the next problem. Simulate it the way a person does:

- Keep a **mistake log** in the project's notes. Every time an assumption
  meets a different reality, write at once: **assumed -> reality -> fix ->
  habit** (the habit is the part that transfers to the next problem).
- **Read the log before starting something similar.** Writing is half;
  reading first is the other half (one model wrote "heredocs break on
  quotes", then broke a patch the same way because it didn't look).
- Examples of habits that transfer:
  - look at the input before fixing the thing that consumes it;
  - before changing a shared value, find every user of it;
  - when a function calls itself, write down what stops it;
  - check your own tool before blaming the system; make tools fail loudly;
  - a check that passes too easily is as suspicious as one that fails;
  - deadlines and limits come from measurement, not a guess;
  - the watcher must not be the only thing that can stop a run;
  - keep logic out of untested glue (a missing shell tool broke a loop).

## 5. Anti-patterns

- Checking everything after every step "to be safe": that's the cost, not
  the safety. Check in parallel, stop on failure.
- Rerunning from the start what already passed.
- Treating a tool's mistake as the system's bug (a bad expression aimed at
  nothing and looked like a range bug).
- Writing the plan only in the chat: write it in a versioned file at once.
- Writing a lesson down and not reading it before the next similar task.
- Making the user list which notes to update: "update the md files" means
  every note the change touches (keep the project's list of them in its
  instructions file).
