# subject-mentor

Build, and run, a **mentorship program for any subject** — the
protocol Gabriel built for his Rust learning hub, reverse-engineered
and generalized.

**What it is:** a repo (the "hub") with a `subjects/` tree
(roadmap, placement test, interview bank, lessons written just in
time) and a `classroom/` tree (progress, weak points, per-lesson
notes, prepared exercise folders), plus an `AGENTS.md` that makes
any agent running inside the hub a teacher that follows the loop:

```
placement test → [ exam → learn → explore → practice → check → record ]
                  (per lesson) → final interview
```

The learner does the thinking; the agent prepares, tests, asks,
reviews, and records. Lessons are written just in time, adapted to
the learner's weak points. Exams only test what was taught.

## Use it when

- You want to teach yourself (or someone) a subject with an AI
  tutor, as a structured program, not a chat.
- You are scaffolding a learning hub repo for a subject.
- You are running a session inside one ("Start lesson m2-l01").

## Files

| File | When |
|---|---|
| `SKILL.md` | The dispatch: which mode you are in, the core rules. |
| `references/hub-scaffolding.md` | Mode S — build the hub: interview the learner, write the files, the quality bar. |
| `references/classroom.md` | Mode C — the session protocol, verbatim (this text is the hub's AGENTS.md). |
| `references/level-ladders.md` | Modes A/D — diagnose the learner, review code and profiles. |
| `templates/` | lesson / notes / placement / final-interview templates. |

## The two iron rules (learned from the first run)

1. **Only ask what was taught.** If a question needs an idea the
   learner has never seen, add the idea to the Learn section first.
2. **You prepare the exercise, the learner writes the code.** No
   copy/paste/rename/delete steps in a beginner lesson.
