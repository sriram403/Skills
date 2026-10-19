---
name: testing-and-verification
description: How to prove a change really works for the user, on any project (games, apps, 3D, pipelines) - assume it's broken until shown otherwise, make checks able to fail, test the way the user will use it, size each test to the change, the watched run (expected outcomes checked in parallel, stop on first failure, resume from that step), the change ledger with a full run only at milestones, resumable long runs, looking critically at every screenshot, and recording a video for the user to verify. Use when testing, verifying, play-testing, writing a test sheet or test plan, before saying "it works", or when tests are slow, flaky or looping.
---

# Testing and verification

**Version: v3 (2026-10-20).** Generalized from the Finding Naresh game's testing method (v1 → v6),
the Kingsway Pick-Up game, the learning-app builds, the Ellie 3D build and the Spirit Box app
(v2: test in the user's container; toasts under dialogs; v3: never fire and forget, check every
run every few seconds while it runs, the user's rule).

**You may ask the user questions at any point**, e.g. what they will judge, which device they use,
whether a long run is worth it now. If you're sure, go ahead.

The scarce thing is **the user's real-world time until a change is proven**, not tokens or machine
time. Every rule below serves that ([`first-principles-solving`](../first-principles-solving/SKILL.md)).

## 1. Ground rules

- **Never fire and forget: watch every run while it runs** (the user's rule, for *all* testing, not
  just some). Whatever you start (a test, a recording, a build, a long script), check it every few
  seconds against the plan: is it at the step it should be, is the thing that should move moving,
  any error in the log? The moment it goes off plan, stop it, look, and say so. Don't start it and
  only read the result at the end. Why: in a game walk the van sat stuck for 1.5 minutes while the
  script waited out its time limit, and the user, watching the window, saw it before the model did.
  How: a background run plus a short check loop on its log/progress file (every 2-5 s), or a watcher
  inside the run (§3) that stops it itself. Both, when you can.
- **Assume it's broken until proven otherwise.** Report honestly: what passed, what failed (with the
  output), what wasn't tested. The user trusts the report only if it's exact.
- **Only the final result counts.** A green check or a small error number is a tool, not proof.
  Judge by what the user will judge (does it play right, does it look like her).
- **Make every check able to fail.** A check that passes too easily is as suspicious as a failing one
  (a "higher than the deck − 0.6 m" check passed while every ramp stopped short; check the exact
  thing). Break the code on purpose once to see the check go red.
- **Test the way the user will get there.** Real inputs, real paths, no teleports, no items handed
  over in code, no hazards switched off. Anything a test gives itself that the user doesn't have
  proves nothing.
- **Test in the container the user runs, not the one you develop in.** A web app wrapped as a phone
  app (Capacitor, Cordova, Electron, a WebView) gets extra JS injected and loses things the browser had.
  In the Spirit Box app, 27 desktop tests passed while every JS button was dead on the phone:
  `Capacitor.registerPlugin` comes from a library the no-bundler app didn't load, so the first line
  threw. No phone or emulator? Run the web side with the wrapper's **real injected script**, add a
  fake native side that logs calls, use a phone-sized touch screen, and **tap every button**, checking
  each one's effect. Then list for the user what only the real device can prove.
- **Reproduce a user report their way** (their menu, their device, solo on one keyboard). Can't
  reproduce it? Instrument it: logs beat guesses.
- **Check the tester before the system.** When a test fails, the test player, the probe or your own
  expression may be the broken part.

## 2. Size the test to the change

Levels, like a team:
1. while fixing: only the checks for that change (seconds; write a throwaway check if needed);
2. smoke: one short check per system (a few minutes);
3. the area set when an area changed;
4. the full run: only at a **milestone checkpoint**, not after every fix or push.

- Never make the user wait on a long run for a small fix, and never rerun a long test because it
  happens to cover a small change.
- **The change ledger:** every change gets an entry as it lands (what changed, what it could break,
  which tests cover it). When the milestone's full run fails, match each failure to an entry.
- **Watch for loops between rules** ("full run after every push" + "push every fix at once" = run,
  fix, push, run, forever). Know a run's cost in minutes before starting it; if each run finds
  something and each fix starts another, stop and tell the user.
- **Before the user's look:** the change's own tests + smoke. The long sets after they agree.

## 3. The watched run (for anything with steps: a game walk, a UI flow, a pipeline)

How a human tester works: play on, and stop only when something that should have happened didn't.
1. **Plan the walk as steps, each with its expected outcome** and a deadline ("Naresh within 3 m of
   the jetty end within 40 s"). Write the positions and outcomes later steps rely on into the plan.
2. **Run the steps back to back**; expectations are *watches* that don't block the actions.
3. **A watcher checks in parallel** (e.g. every 0.1 s): open watches, plus always-true rules (no
   script error, nothing that should move stands still > 5 s, no give-up line). The "stands still"
   rule must cover **everything that should move** (players, vehicles, NPCs), and the watcher must
   never switch itself off when one of them is missing: one returned early when a character wasn't
   in the scene, which silently skipped the step limits too, and a stuck vehicle went unwatched.
4. **On the first FAIL: stop the actions, keep the world live**, write a report (the failed watch,
   state, logs, one screenshot), exit so you're told at once. No polling; do other work meanwhile.
5. **Fix, then resume from the failed step** from a save point taken at each step's start, not from
   the beginning.
6. A walk that runs clean end to end is its regression test.

Version history that led here (keep it in mind when tempted to go back): judged-at-the-end scripts
(dead runs carry on) → fail-fast (fixes restart from zero) → one command at a time (the model's think
time became the biggest cost) → the watched run.

## 4. Show it: evidence the user can check

- **Look at every screenshot critically**, as the user would, not to confirm a check. Most bugs are
  found in the pictures. Anything that looks off is a bug. Take a second angle before concluding.
  Screenshot feedback messages (toasts, banners) **while a dialog is open** too: a modal `<dialog>`
  sits in the browser's top layer, so a toast in `<body>` shows dimmed underneath it. Put the toast
  inside the open dialog. (`elementFromPoint` can't check this for `pointer-events: none` elements.)
- **Look from where the user stands:** close-ups of every new thing; the exact angle the user looks
  from (if they had to show you an angle, add it to your loop).
- **Record the run as a video** for the user to verify before they play; watch it yourself first
  (frame grid: `ffmpeg -i x.mp4 -vf "fps=1/10,scale=400:-1,tile=5x6" -frames:v 1 grid.jpg`). Send it with
  times for each step and what to judge. Videos show causes logs can't.
- **Side-by-sides for visual work**: reference | before | after, zoomed where the change is small.
- **List every region and the view that checks it.** No view = not checked; say "not checked".

## 5. Long runs

- **Resumable:** each finished part goes to a progress file; `resume` skips them. A failing part
  doesn't stop the run; report everything at the end.
- **Every wait gets a deadline** that fits it; the watcher must not be the only thing that can stop
  a run. Trust only the summary line: no summary means it didn't finish.
- **Fail fast on setup:** compile/parse first so a typo stops the run in seconds, not at a timeout.
- **Each test sets up its own state** (time of day, positions, items) and puts back what it changes;
  the full order exposes tests that lean on earlier ones.
- **Flaky means the measurement is wrong**, not "rerun it".
- **Never edit files a running test will load.** Work in a second copy (a git worktree) meanwhile.
- **Don't assume one-at-a-time:** measure whether two instances can run at once on this machine.
- **Test runs must not disturb the user:** windows behind theirs, muted, no focus stealing.
- **Game time vs wall clock:** a fast/headless run's time isn't real time; measure in the system's
  own clock (frames, ticks).

## 6. Before saying "done"

- [ ] The change's own checks pass, and each was seen failing once.
- [ ] Walked the user's real path with the user's inputs.
- [ ] Looked at the screenshots/video myself, critically, from the user's angles.
- [ ] Wrote what wasn't tested.
- [ ] Ledger entry written; notes updated ([`project-memory`](../project-memory/SKILL.md)).
