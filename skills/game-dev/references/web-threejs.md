# Three.js / browser game notes (from a one-day car-park puzzle build)

Stack that worked: Vite + plain JavaScript modules + Three.js; `npm run dev` for play, `npm run build`
for a static copy. Tests through `playwright-core` driving the Chrome already installed on the PC (no
browser download).

## Test tooling

| Tool | What it does |
|---|---|
| `check-levels` script | every level builds; counts and sizes in < 1 s |
| headless play-through | plays every level to the end in **game time**; reports win/lose, collisions, "two moving things closer than X", anything stuck; saves screenshots |
| `probe.mjs "<js>"` | runs any expression in the page, optional screenshot |
| `window.<game>` hooks | `sim(level)`, `hint()`, `blocked()`, the game object |

## Gotchas

- **`mergeGeometries` returns null** when some geometries are indexed and some not. Convert all to the
  same form first, and throw if a merge fails.
- **`setTimeout` is wall-clock:** a fast test runs game time without real time passing, so delayed
  events never happen. Use a `game.later(seconds, fn)` on the game's clock.
- **Hidden/minimised/covered windows get no `requestAnimationFrame`.** If the world must keep going,
  advance it by the wall clock with a slow timer and play any gap through on return (capped, e.g. 5
  minutes). Headless Chrome never hides the page, so test this with a real minimised window.
- **The test player can be the weak part:** a level "failed" because the bot ignored seats already
  waiting. Fix the tester first.
- **Close-ups find what wide shots hide** (a lamp post in the middle of a bay; a head poking through a
  car roof while boarding).
- Path-following agents: look ahead along their own route and check other agents' real outlines;
  wait for every lane a reversing car crosses, and count where a moving car *will* be, not where it is.
