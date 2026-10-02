---
name: learning-skill
description: Build a complete, visual, interactive learning app (course + hands-on labs + source viewer + glossary + cheat sheet) that takes the user from zero to expert-level fluency on ANY topic or set of source materials (PDFs, docs, a song, a codebase, a domain). Built on Elon Musk's first-principles, semantic-tree and "teach to the problem" methods. Use when the user says "learning skill", "teach me X end to end", "help me understand these materials", "build a learning thing for X", or points at this file.
---

# Learning Skill

**Mission:** Given a topic (and optionally source materials), build a self-contained learning app so the user can understand the topic end to end — everything the sources say, and everything they silently assume — well enough to hold a real conversation with a 10+ year expert, and to reason about it themselves.

Two builds prove the pattern (look at them if they exist on this machine; don't depend on them):
- `D:\mine\Agentics\T3_Code_Works\music_understanding\playground\` — music theory taught *on a real song* (studio + story-driven academy with tasks the app checks automatically).
- `D:\mine\jags\Learning\basics\lexbolt_academy\` — two business PDFs (vehicle regulation + AI strategy) taught from zero: 29 chapters, 13 labs, every PDF page explained, 231-term glossary.
- `D:\mine\jags\ashok\specextract_journey\` — **the user's favourite so far.** A codebase (a PDF-to-JSON extractor) taught as "follow one PDF from bytes to JSON": real page on the left with toggleable overlays, lessons on the right, a purpose-built practice PDF, click-through visual steppers driven by the engine's real trace. See **Case study** at the end of this file.

> **These builds prove the *method*, not a UI template. Do NOT copy their layout, flow or look.** Every project gets its own flow and UI, designed around what that project is and how it's best learned (a codebase might be taught as a guided walk through a request's journey; a pipeline as a step-by-step data trace; a song as a studio). The layout, routes and file list in Step 4 are a starting skeleton only — change, drop or replace any part of them when the project calls for it.

---

## 1. The principles (from Elon Musk). They apply to what you teach AND to how you build it.

| # | Principle | What it means for this skill |
|---|---|---|
| 1 | **First principles, not analogy.** "Boil things down to the most fundamental truths… and reason up from there." | Find the handful of basic truths the topic rests on, and build every chapter up from them. Use analogies only to *explain* (as bridges from the learner's own field), never as the *proof*. |
| 2 | **Knowledge is a semantic tree.** "Make sure you understand the fundamental principles, i.e. the trunk and big branches, before you get into the leaves/details or there is nothing for them to hang on to." | The curriculum is trunk → branches → leaves. No detail appears before the concept it hangs on. Every chapter states where it sits in the tree. |
| 3 | **Teach to the problem, not the tools.** "Here's the engine. Now let's take it apart… that's what the screwdriver is for." | The learner's real artifact (their PDF, song, codebase, product) is the engine. Take it apart. Introduce each concept (tool) at the moment it's needed to understand the artifact. |
| 4 | **The "why" is everything.** "Our brain has evolved to discard information that it thinks has no relevance." | Every fact carries its why-it-matters. If a paragraph has no "so what" for the learner's goal, delete it. |
| 5 | **The Algorithm, in order:** (1) question every requirement, and put a name on it, (2) delete, (3) simplify/optimise, (4) accelerate the cycle, (5) automate. | (1) Every chapter/lab must name the learner goal it serves. (2) Cut anything that doesn't; if you never have to add ~10% back, you didn't cut enough. (3) Simplify what's left. (4) Tighten the feedback loop: instant quiz answers, live labs. (5) Only then polish tooling and automation. Never polish content that should have been deleted. |
| 6 | **Physics is the law; everything else is a recommendation. Assume you're wrong, and aim to be less wrong.** | Separate hard facts from conventions and from opinions. Verify numbers against the source. When unsure, use a general label rather than inventing a specific (a standard number, a date). Add one honest caveat, and point to the learner's expert as the tie-breaker. |
| 7 | **Idiot index** (finished cost ÷ raw-material cost). | Learning idiot index = time spent ÷ understanding gained. Keep chapters around 10–15 minutes, with one idea per section. A picture or lab beats three paragraphs. |
| 8 | **Seek negative feedback.** | Quizzes explain *why* the wrong option is wrong. Critique the source itself: check its arithmetic, spot inconsistencies, and name what it leaves out. That's what makes the learner sound like an insider. |
| 9 | **Maniacal urgency; ship, then iterate.** | Get a working v1 end to end fast, test it in a real browser, then refine. Urgency starts *after* intake: clearing up doubts with the user first (Step 0) is faster than rebuilding. |
| 10 | **Cross-disciplinary transfer.** | Map every hard concept onto the learner's own field (e.g. for an AI engineer: COP = production drift monitoring, traceability = data lineage). |

---

## 2. The procedure (follow in order)

### Step 0: Intake — ask the user everything you're unsure about, BEFORE building
First look over the sources/project enough to know what you don't know. Then, **before building anything, ask the user all your doubts and questions** — about them (background, what they already know, why they're learning this, who they'll talk to) and about the project (what it's for, unclear parts, what matters most, which parts to skip, preferred flow/UI). There is no limit on questions; the user welcomes them. Ask in one organised batch where possible (follow-ups are fine). Only for things the user leaves unanswered, **use the default and state it**:
- **Topic and sources.** Files, links, or an artifact. Default: research the topic yourself.
- **Learner.** Their background (this becomes the analogy domain). Default: expert in their own field, beginner in this topic.
- **Goal.** Default: "understand everything end to end, and converse fluently with a 10-year veteran".
- **Output location.** Default: a new folder `<topic>_academy/` next to the sources.

When the user comes back with feedback on a build, ask again before rebuilding, but only the questions whose answer changes the build (e.g. where practice examples go, what the practice artifact is about, how many explanation levels). Offer a recommended option for each.

### Step 1: Take the engine apart (source analysis)
1. Read **every** source completely. For PDFs: extract the text (`pdftotext -layout`) **and** render the pages as images (`pdftoppm -jpeg -r 120 file.pdf out/prefix`), then look at the visual pages; text extraction misses charts and layout.
2. **Map pages correctly.** Page 1 is often a title page, so "slide N" ≠ page N. Build a `page → title → one-line meaning` table and check it against the images. (This bug happened once; don't repeat it.)
3. Inventory every **claim, number, example, diagram and term**. Reproduce every number (e.g. "6 × 4 × 40 + 192 = 1,152 h").
4. List what the sources **assume you already know**. That list is your Beginner and Intermediate levels.
5. Find the **one core diagram / mental model** everything hangs on (e.g. a traceability chain, a song's structure). It goes in the Orientation level and gets reused throughout.
6. Find what the sources **don't** say: gaps, inconsistencies, unstated assumptions, missing data or evaluation, risks. These become "insider" insights.
7. Research the background knowledge. Mark each fact as solid or uncertain; soften the uncertain ones.

### Step 2: Design the semantic tree (curriculum)
Use this level template and adapt the names to the topic:

| Level | Purpose | Typical chapters |
|---|---|---|
| **0 Orientation** | What the sources are, and the whole story in 5 minutes | "Start here", "The whole story", the core diagram |
| **1 Beginner** | The trunk: the world the topic lives in | who the players are, basic objects, the fundamental rules, the lifecycle |
| **2 Intermediate** | Big branches: how it really works day to day | processes, tools, jargon in context, where the pain is |
| **3 Advanced** | Source A decoded, section by section | quote → unpack → critique |
| **4 Expert** | Source B, or deep application in the learner's own discipline | "how I'd build/do it", data needed, how to evaluate, risks |
| **5 Mastery** | Real-world use | regional/contextual nuances, mock dialogues, smart questions to ask, things NOT to say |

**Chapter contract** (every chapter has all of these):
- A `lead` sentence (why this chapter exists), and source-page pills linking to the exact pages.
- A body where each section introduces ≤ 1 new idea, with **visual structure**: tiles, flows (A → B → C), tables, and embedded labs.
- An **analogy box** to the learner's field, where it genuinely helps.
- Callouts: `warn` (a caveat or common mistake), `pro` (insider nuance), and a context callout (e.g. regional differences).
- The source quoted **verbatim** when decoding it, then unpacked phrase by phrase.
- 📖 **"Words used here" box** before the text: every new term defined in beginner-to-intermediate-programmer words and tied to the current case, *before* it is used. Never write "the right edge votes; the most common wins" to someone who hasn't been told what an edge, a vote or "most common" is: the user stops reading at the first undefined word.
- **Visual first.** Any mechanism involving positions, geometry, order, counting or state changes gets a picture or a click-through stepper, not a paragraph. "Adds 0.05 pt to the top of the row" must be *shown* (a line moving, with a magnified inset), and coordinates must be *drawn* (a box on a ruler), never only stated.
- **Explained two ways + together** at the end: (1) for a ~19-year-old new programmer, with an everyday analogy; (2) for an intermediate programmer, in precise technical terms; (3) one "putting it together" passage that joins the real case (the learner's own artifact and numbers) with a real-world analogy, so whichever explanation landed, the chapter comes together.
- 🔑 **Key takeaways** (3–4 bullets).
- 💬 **"Say it like a pro"**: 1–2 sentences the learner could actually say to an expert.
- ✅ **Quiz**: 2–3 multiple-choice questions, each with an explanation of why.
- Glossary markup on every term of art.

Aim for roughly 20–30 chapters for a two-document topic. Scale down for smaller topics. **Delete before you add.**

### Step 3: Design the labs (learning by doing)
A lab exists only if **doing** teaches more than reading. Each lab mirrors a core concept or a specific claim in the sources, **reproduces the source's own example as a preset**, and explains every output ("why:").

| Concept type | Lab form |
|---|---|
| Classification | Inputs → category + reason, with presets for real cases |
| Rules / decisions | Rule engine with three outcomes (yes / no / needs info), a "why" per result, and a "next best question" (the question that resolves the most unknowns) |
| Dependencies / relationships | Clickable graph: click a node to trace upstream and downstream; scenarios colour the impact |
| Process / lifecycle | Clickable step flow or phase strip with details |
| Dates / thresholds | Timeline with sliders that shows which rule applies |
| Quantities / business cases | Calculator that shows its formula and resets to the source's numbers |
| Trends / monitoring | Line chart with hover tooltip, thresholds and a detection method (e.g. a smoothed moving average, EWMA) |
| Scoring / prioritisation | Sliders + a sorted bar chart of contributions (the explanation) |
| Before / after | A toggle between "today" and "with the solution" |
| A real artifact (audio, image, code, data) | An inspector/player on the actual artifact, e.g. the music studio's per-instrument tracks, loop, solo and mute |

Guided-task pattern (from the music build): **▶ Show me** buttons that set the lab up, plus **tasks the app ticks off automatically** when the learner does the thing.

**Practice artifact first, real artifact second.** When the real artifact is messy (real PDFs with odd coordinates, a big codebase, noisy data), build a *small purpose-made practice artifact* that contains exactly one example of each rule, with round, readable numbers (columns at x = 90 / 240 / 300, rows 22 pt tall). Generate it with a script (no special libraries needed: a PDF can be written by hand with drawing operators). Run the **real** engine on it. Each lesson then shows the rule on the practice artifact (easy to follow by eye) and immediately on the real artifact (proof it matters).

**Click-through steppers driven by the real trace.** For algorithms, make a stepper (◀ Back / Next step ▶ / "step n of m") whose every frame is computed from the engine's actual intermediate results, not a hand-drawn illustration: e.g. find the row top → nudge the ruler → sweep left to right lighting each crossed box → result list; or each row drops a vote on a tally board → winner draws the line. Let the learner switch the input (Van / Bus / Mini, practice page / real page) and watch the outcome change. The user called the clickable "change something and see the output react" labs the best part.

### Step 4: Build the app
**Design the flow and UI for THIS project first.** Decide what the learner's journey should feel like for this particular material (e.g. follow one document through the pipeline, a debugger-style step-through, a map of the system you drill into) and shape the pages around that. Everything below is a default skeleton, not a template to copy — the previous builds' UI is not the target.

**A layout that worked very well for a codebase/pipeline (SpecExtract):** the real artifact on the left (page image + toggleable overlay layers + an inspector that explains the engine's decision for whatever is clicked), the lesson on the right split into small "beats" (one idea each, ← → keys), a metro line of stations at the top, and a checkpoint per station (takeaways, the two-way explanations, a quiz). Every page or item a lesson mentions is a link that **switches the left panel** to it, with a "↩ Back to lesson page" button: the learner must never have to go find a referenced page by hand.

**Stack:** plain HTML + CSS + vanilla JS. No build step, no dependencies, **works by double-clicking `index.html`** (so no `fetch()`: content lives in `.js` files that assign to `window`). Only if you need audio or large data, add a tiny no-cache `serve.py` plus a `play.bat`.

**Files:**
```
<topic>_academy/
  index.html      header nav + sidebar + main; loads the scripts in order
  style.css       tokens: dark default + light theme, one accent colour
  glossary.js     window.GLOSSARY = { KEY: {f: full name, c: category, d: plain definition} }, plus GLOSSARY_ALIAS
  course.js       window.LEVELS = [...]; window.CHAPTERS = [ {id, level, title, sub, src:[pageIds], body, takeaways, say, quiz:[{q, opts, a, why}]} ]
  course2.js      window.CHAPTERS.push(...)  (split content across files so each stays readable)
  labs.js         window.WIDGETS = { name: {title, sub, lab: true|false, render(el)} }
  core.js         router, markup expansion, tooltips, lightbox, quizzes, progress, pages
  slides/         rendered source pages (e.g. deck-01.jpg, ai-01.jpg)
  README.md, open.bat   (open.bat: @echo off / start "" "%~dp0index.html")
```

**Markup conventions** (expanded by `core.js` at render time):
- `[[KEY]]` or `[[KEY|shown text]]` → dotted-underlined term; hover shows its definition; click opens the glossary.
- `{{slide:deck-08|caption}}` → embedded page image; click to enlarge.
- `{{src:deck-08}}` → a "📄 PDF 1 p.8" pill that opens the lightbox.
- `<div data-widget="name"></div>` → mounts a lab inside a chapter.

**Pages (hash routes):**
- `#/home`: title, "Start / Continue" button, the level path with progress bars, jump-in tiles.
- `#/academy/:id`: sidebar grouped by level with ✔ marks; chapter view with prev/next and a "Mark complete" button that auto-advances; progress stored in `localStorage`.
- `#/labs/:name`: all labs, each also embedded in its chapter.
- `#/sources/:doc`: every source page as a card (image + one-line meaning + link to its chapter); lightbox with ← → keys.
- `#/glossary/:term`: search, category filter, scroll to and highlight the term.
- `#/cheat`: the 60-second version, a numbers-and-names table, flashcards (Space to flip), links to the conversation drills.

**Visual rules:**
- Colour carries meaning only together with an icon and a label (✔ ▲ ◆ ✖).
- Charts: thin 2px lines, a legend when there are ≥ 2 series, a hover tooltip, a labelled threshold line, never two y-axes, and a colour-blind-safe palette (e.g. blue `#3987e5`, orange `#d95926`, aqua `#199e70`, yellow `#c98500`, violet `#9085e9`).
- Status colours: good `#0ca30c`, warning `#fab219`, serious `#ec835a`, critical `#d03b3b`.
- Keep labels from overlapping the data (check in screenshots).
- Every lab's "why" text is written for the learner, not the developer.

### Step 5: Verify (assume it's broken until proven otherwise)
1. `node --check` every JS file.
2. Run a Node script that loads the content files and asserts that every `[[term]]` resolves, every `data-widget` exists, and every page reference has an image.
3. Open it in a real browser and visit **every** route while collecting JS errors (loop over `window.CHAPTERS` and `window.WIDGETS`).
4. Take screenshots of the key pages and labs and **look at them**. Headless Edge or Chrome works:
   `msedge --headless=new --disable-gpu --hide-scrollbars --user-data-dir=<tmp> --window-size=1400,1500 --virtual-time-budget=4000 --screenshot=<out.png> "file:///<path>/index.html#/labs/x"`
   Then fix overlaps and illegible text.
5. Fact pass: every source number reproduced, page mapping checked against the images, uncertain specifics softened, one caveat in Orientation.
   For a codebase: generate the app's data **by running the real code** (a build script that re-runs the engine and records a per-step trace), and **assert the trace reproduces the engine's real output record by record**, so the app can never show something the code doesn't do. If labs re-implement rules in JS, add a Node verifier that checks the JS port against the real outputs on every case. When the engine changes (a new version), rebuild the data and update every lesson that quotes old behaviour or numbers.
   Also check every claim written in a lesson against the data (e.g. "the average would split boxes wrongly" turned out false for the practice form and had to be reworded honestly).
6. Test from `file://` as well as from a server.
7. **Small-detail sweep** (the user notices these immediately and they break trust): every dropdown/selector also updates whatever else shows that thing (the page panel); every input is readable in the dark theme (white-on-white text was a real bug); diagrams of thin strips are stretched or zoomed until their text is readable at a 1280 px window; click every stepper to its last step with a script and collect errors. Background browser tabs throttle timers, so drive route checks synchronously (dispatch `hashchange`) rather than with `setTimeout` waits.

### Step 6: Apply the Algorithm, then ship
Run one more pass: question each chapter (does it serve the goal?), delete, simplify. Then write a README and report back to the user: the path, how to open it, what's inside (a table), what was verified, and honest caveats. Keep the report short.

---

## 3. Quality bar (all must be true)
- [ ] A complete beginner can start at chapter 1 with no outside help.
- [ ] Every page of every source is explained somewhere and linked back.
- [ ] Every term of art has a hover definition.
- [ ] The core diagram appears in Orientation and recurs in later chapters.
- [ ] Each level ends with the learner able to *say* something true and non-obvious.
- [ ] At least one lab reproduces a concrete example or number from the sources.
- [ ] The app includes at least one piece of critique of the sources (a gap, an arithmetic check, a missing assumption).
- [ ] The Mastery level has mock dialogues, smart questions and things not to say.
- [ ] Zero JS errors across all routes; screenshots were reviewed.
- [ ] It opens by double-click, offline.
- [ ] No term is used before it is defined; every mechanism has a visual.
- [ ] Every referenced page/item is clickable into the main viewer, with a way back.
- [ ] Every chapter ends with the two-way explanation plus the combined passage.

## 4. Anti-patterns (delete on sight)
- Tool-first teaching ("Chapter 3: all 40 terms") with no artifact to hang them on.
- Leaves before trunk: details that appear before the concept they belong to.
- Walls of text where a flow, a table or a lab would do.
- Invented specifics (standard numbers, dates, statistics) that you haven't verified.
- Automating or polishing before deleting: fancy widgets for content that shouldn't exist.
- Quizzes that test recall of trivia instead of understanding.
- Analogies used as proof.
- Jargon-first beats ("its right edge is one vote, the most common wins") with the definition never given or given after.
- Describing geometry, coordinates or tiny offsets in prose instead of drawing them.
- Text that mentions another page the learner then has to open manually.
- Illustrations that are not computed from the real artifact's data (they drift from the truth).

---

## Case study: SpecExtract Journey (the build the user loved)

**The problem.** The user (an AI/ML engineer who builds with AI help) had a working project, a deterministic extractor that turns Ashok Leyland AIS-007 specification PDFs into traceable JSON (pdfplumber geometry → cells → active cells per row → value boundary vote → records → hierarchy → JSON, plus a FastAPI app and a holdout evaluation). They had to explain and defend it to a client, tech leads and interviewers, but were new to PDF internals and extraction.

**What the user wanted.** To truly own the code: understand every rule from zero, be able to explain it at different depths, and know its limits honestly. Specifically: visual, not text-heavy; every word explained before use; practical, "like teaching a child an experiment"; references clickable; explanations at their level.

**What was built, and why.**
| Choice | Why |
|---|---|
| Flow = "follow one PDF from bytes to JSON", 14 stations on a metro line | A pipeline is best learned as a journey of one document through it; the metro line shows where you are in the core diagram. |
| Real page on the left with overlay layers (words, ruling lines, cells, row roles, value boundary, images) and a row inspector | Teach to the engine: the learner clicks the actual artifact and sees the engine's decision for that exact row, with the reason. |
| Data built by re-running the real engine, with a faithfulness assertion | The app can never show behaviour the code doesn't have; rebuilt when the engine went from v1.0 to v1.1. |
| JS ports of the rules + a Node verifier (4,000+ checks) | Labs run the real rules live (drag the value boundary, edit codes to build the tree) and are proven equal to Python. |
| A purpose-made one-page practice PDF (generated by a script, round coordinates, one example of each rule) | The real pages were too dense to follow by eye; the practice form made each rule visible, then the real page proved it. |
| Click-through steppers computed from the trace (ruler across a row with a zoom inset for 0.05 pt; votes dropping on a tally board; five questions per row; headings attaching to answers; tree growing; JSON value ↔ box) | The user did not understand rules described in prose; seeing each step with real numbers made it click. |
| "Words used here" boxes, two-way explanations + combined passage per station | The user stopped reading at the first undefined term; different explanations land for different readers. |
| Page atlas, code reader with notes per function, glossary with hover, defense room (client / tech lead / interviewer drills), cheat sheet with flashcards | They needed to defend it in real conversations, not just read about it. |

**What the user loved.** The lessons on the real page with explanation alongside; the clickable labs where changing something visibly changes the output (the merged-cell "who owns this row" lab); the visual steppers; the practice form; the honest limits and evaluation story ("why 97.3% is not the accuracy", regression vs unseen).

**What failed first (and the fix).** v1 of lessons 5+ used terms before defining them ("right edge", "vote", "Counter.most_common") and described geometry in prose ("adds 0.05 pt") → rewritten words-first with steppers. Referenced pages had to be opened manually → every reference switches the left page. A lab dropdown didn't update the page; a lab input was white-on-white → fixed and added to the verification sweep. One lesson claim (that averaging would mis-sort boxes) was not true on the practice data → reworded to the honest version. Lesson: verify the *teaching claims* against the data, not only the code.

---

## Sources for the principles
- The Algorithm (5 steps): [Startup Archive](https://www.startuparchive.org/p/elon-musk-explains-his-5-step-algorithm-for-running-companies-1eae), [ModelThinkers](https://modelthinkers.com/mental-model/musks-5-step-design-process), [Corporate Rebels](https://www.corporate-rebels.com/blog/musks-algorithm-to-cut-bureaucracy)
- Semantic tree of knowledge: [Farnam Street](https://fs.blog/elon-musk-knowledge/)
- First principles vs analogy: [James Clear](https://jamesclear.com/first-principles), [Farnam Street](https://fs.blog/first-principles/)
- Teach to the problem, not the tools: [CNBC](https://www.cnbc.com/2017/07/20/elon-musk-this-question-can-help-fix-the-u-s-education-system.html)
- Idiot index and feedback (Isaacson biography notes): [Graham Mann](https://grahammann.net/book-notes/elon-musk-walter-isaacson), [Christian Houmann](https://bagerbach.com/books/elon-musk/)
