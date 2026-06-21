# Red Seal Rescue — Coaching Toolkit

A single-file coaching app for Red Seal Rescue. Four tools in one, tied together
by a shared client file:

1. **Readiness Intake** — a self-rating + timed diagnostic that scores a new
   client's baseline, flags their weak competency blocks, and recommends a plan.
2. **Mock Exam** — a timed, Red Seal–format multiple-choice exam (70% to pass)
   with per-block scoring and full answer review with rationale.
3. **Study-Plan Generator** — back-plans week-by-week from the exam date,
   front-loads weak blocks, and ends with mock exams + review. Check tasks off
   to track progress.
4. **Coach Dashboard** — the whole roster at a glance: readiness, last mock,
   exam countdown. Click any client for their full file.

## How to run

It's one file. **Double-click `index.html`** — it opens in any browser and runs
fully offline. No install, no server, no internet needed.

(While developing in Claude Code it's served at `http://localhost:4178`.)

## Duplicate clients

The app prevents duplicate client files: running an intake or "New client" for
someone already on the roster (same name + trade, ignoring case/spacing) reuses
their existing file instead of creating a second one. If you have duplicates
from before this safeguard, the **Dashboard** shows a "possible duplicate" banner
— click **Review & merge** to fold the records into one. Merging keeps the oldest
file and combines every exam, session, intake, and the most recent plan. Nothing
is lost.

## Your data

Everything is stored **locally in your browser** (`localStorage`) — nothing is
sent anywhere. Because it's per-browser:

- Use **Export** (Dashboard) to download a JSON backup.
- Use **Import** to restore it, or to move data to another computer/browser.
- Clearing your browser data will erase clients — back up first.

## Trades & questions

Four trades are seeded: **Construction Electrician (309A)**, **Industrial
Mechanic / Millwright (433A)**, **Welder (456A)**, **Plumber (306A)**, each with
real questions tagged to competency blocks.

All four banks are now exam-grade — **40–42 questions each**, spread evenly
across the five competency blocks (~163 questions total), with a worked
rationale on every question:

- **Construction Electrician (309A)** — 42 Qs, cited to the **2024 Canadian
  Electrical Code (CSA C22.1:24)**: Rule 8-102 (voltage drop), 8-200 (dwelling
  load), 8-304 (outlets/circuit), 2-308 (working space), 26-704 (GFCI), 26-706
  (tamper-resistant), 26-724 (AFCI).
- **Industrial Mechanic / Millwright (433A)** — 41 Qs: rigging, bearings &
  lubrication, pumps & drives, alignment, hydraulics & pneumatics.
- **Welder (456A)** — 40 Qs: safety/setup, metallurgy, SMAW, GMAW/FCAW, symbols
  & inspection.
- **Plumber (306A)** — 40 Qs, cited to the **National Plumbing Code of Canada
  2020**: 2.2.3.1 (trap seal 38/50 mm), 2.4.8 (slope), 2.4.10 (fixture-unit
  hydraulic loads), 2.2.10.15 (water-hammer arresters), 2.2.10.16 (AAVs),
  back-siphonage / air-gap definitions.

### Adding more questions — the easy way (in the app)

Open the **Question Bank** tool in the sidebar. Pick a trade, click **＋ Add
question**, type the question and four options, mark the correct one, and add a
short "why". That's it — your custom questions are saved in the browser, appear
immediately in mock exams and intakes, can be edited or deleted anytime, and are
included in your **Export** backup. Built-in questions show a "built-in" badge
and are read-only; your additions show a "custom" badge.

### Adding more questions — the advanced way (editing the file)

You can also hard-code questions into the file so they ship with the app for
everyone. Open `index.html` and find the `QUESTIONS` array near the top of the
`<script>`. Each entry is:

```js
{ trade:"electrician", block:"Circuits & Theory",
  q:"…question text…",
  opts:["A","B","C","D"], answer:2,   // answer = 0-based index of correct option
  why:"…short rationale shown in review…" }
```

Blocks must match the `blocks` list for that trade in the `TRADES` object. To add
a whole new trade, add it to `TRADES` (with its 5 blocks) and add a matching
section to `STUDY_TASKS` so the plan generator has tasks for it.

## Notes

- Pass mark is modelled at **70%** (the Red Seal standard) — change the `PASS`
  constant at the top of the script to adjust.
- All four banks (~163 questions) cover the core competencies, but a real
  Red Seal exam draws on a much larger pool. Have a trade expert review and keep
  expanding each bank before relying on scores for high-stakes go/no-go calls.
