---
name: research
description: How to research or learn anything fast and reliably for the user, on any project, using Elon Musk's learning principles (first principles, the semantic tree, teach to the problem, the "why", assume you're wrong). Covers framing the question, finding primary sources and many references, marking facts solid vs uncertain, the smallest experiment instead of more reading, and gathering images/video frames/downloads from the web. Use when the user says "research X", "find out", "look into", "gather references", "how do pros do X", "compare options", or before any build that depends on facts you haven't checked.
---

# Research and learning, fast

**Version: v1 (2026-10-15).** Pulled together from the user's projects: reference gathering for a 3D
likeness build, researching professional workflows, the learning-app builds, and the game's
"measure before you assume" habit.

**You may ask the user questions at any point**: what the research is for, which sources they trust,
whether a download or a new tool is OK. If you're sure, go ahead.

Related: [`first-principles-solving`](../first-principles-solving/SKILL.md) (the method behind this),
[`learning-skill`](../learning-skill/SKILL.md) (turning research into a course for the user),
[web gathering techniques](references/web-gathering.md).

## 1. The principles (Elon Musk's, applied to research)

| # | Principle | In research |
|---|---|---|
| 1 | **First principles, not analogy** | Find the few basic truths the topic rests on. "Everyone does it this way" is a lead to check, not an answer. |
| 2 | **Knowledge is a semantic tree** | Get the trunk and big branches (what the thing is, how it works, what limits it) before leaves (settings, edge cases). Details with nothing to hang on are forgotten. |
| 3 | **Teach to the problem, not the tools** | Research only what the actual task needs; learn a tool at the moment the problem needs it. |
| 4 | **The "why" is everything** | Each fact you keep carries why it matters for the task. No "so what" → drop it. |
| 5 | **The algorithm** | Question what you're asked to find (who needs it, for what decision?), delete side quests, simplify, shorten the find → test loop, automate repeated gathering last. |
| 6 | **Physics is the law; everything else is a recommendation. Assume you're wrong.** | Separate hard facts, conventions and opinions. Verify numbers at the source. Say "unverified" rather than inventing a specific. |
| 7 | **Seek negative feedback** | Look for what contradicts your first answer; note gaps and where sources disagree. |
| 8 | **Cross-disciplinary transfer** | Map the new topic onto something the user already knows. |

## 2. The procedure

1. **Frame it.** One line: what decision or build does this research serve, and what would "enough"
   look like? Ask the user if unclear. Time-box it (say the box).
2. **Map the whole territory, not just the asked-about part.** When the user is new to a field,
   what they list is a starting point, not the scope: they can't name what they don't know exists.
   Sweep the full landscape (official docs' table of contents, official learning paths, what pros use
   daily), triage core / good to know / skip, and flag what they didn't ask about but will need (the user).
3. **Smallest experiment beats more reading.** If a 2-minute test answers the question (does the tool
   run on this PC? are two instances OK? does the API accept this?), run it instead of reading about
   it. Never accept a limit you haven't tested.
4. **Primary sources first:** official docs, the source code, the spec, the original paper, the
   professional's own write-up. Summaries and forums second, and marked as such.
5. **More references beat more cleverness.** If you can still find more relevant references (other
   angles, other cases, other sources), you haven't finished looking. Front and side are the minimum,
   never the goal.
6. **One consistent source first.** Mixing versions (two games, an old and a new API, the actor and
   the character) gives an answer that matches none. Use others only to fill gaps, and mark them.
7. **Mark every fact** solid (seen at the source, reproduced) or uncertain (one secondary source,
   memory). Reproduce every number you'll rely on.
8. **Look at how professionals do it.** For any craft (character art, game testing, data pipelines),
   search for the pros' workflow before inventing one; adapt it to the free tools you have.
9. **Write it down as you go** in a file in the project (sources with links, what each was used for,
   what's still open), not only in the chat. Index gathered material (file, source, what it shows,
   quality, used for), e.g. `refs/INDEX.md`.
10. **Report:** the answer first, then how sure you are, the sources (links), and what you couldn't
   verify. Short and plain.

## 3. Habits from real mistakes

- **Never judge from memory; keep the reference in the loop.** Comparing against a mental picture
  wasted hours; side-by-sides with the real reference settled it at once.
- **Measure an impression before acting on it.** "Looks too big" was false more than once.
- **Ask the user early for references or a download OK**, especially the ones that are hard to find
  (a side view, an official sheet, access to a private doc).
- **Read 3D structure off side/back references, not fronts** (a "low ponytail" was a half-up tie).
- **Licences matter:** note each tool's or asset's licence when you find it (CC0, non-commercial,
  commercial). Default to free/open-source unless the user says otherwise.
- **Don't bypass protections** (Cloudflare checks, logins, ToS): find the same material another way.
- **Search results disagree:** say so, give both, and say which you'd trust and why.

## 4. Anti-patterns

- Reading for an hour about a limit a 2-minute test would settle.
- A wall of findings with no decision attached.
- Invented specifics (numbers, dates, standards) you haven't verified.
- Gathering stops after the first few references "because they look fine".
- Downloads dropped next to scripts, or anywhere outside the project folder.

## Sources

- First principles: [James Clear](https://jamesclear.com/first-principles), [Farnam Street](https://fs.blog/first-principles/)
- The semantic tree: [Farnam Street](https://fs.blog/elon-musk-knowledge/)
- Teach to the problem, not the tools: [CNBC](https://www.cnbc.com/2017/07/20/elon-musk-this-question-can-help-fix-the-u-s-education-system.html)
- The algorithm: [ModelThinkers](https://modelthinkers.com/mental-model/musks-5-step-design-process)
