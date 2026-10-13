# Building the learning hub (mode S)

The hub is a repo with four parts.

```
<root>/
  README.md            what this is, how to use it, the entry commands
  AGENTS.md            the agent's instructions (the CLASSROOM.md protocol)
  subjects/
    _templates/        lesson, notes, placement, final-interview (from templates/)
    NN-slug/
      ROADMAP.md
      placement-test.md
      interview-questions.md
      lessons/
        mX-lYY.md      written just in time, one per lesson
  classroom/
    PROGRESS.md
    WEAK-POINTS.md
    NN/
      notes/
      exercises/
        mX-lYY/
          <files the learner writes in>
          answers.md
```

`NN` is the subject's number in the hub; `mX-lYY` is module X,
lesson YY. One subject per numbered folder, even if the hub holds
several subjects.

## Interview the learner (before writing anything)

1. The subject and the target, in observable behavior: "after this
   I can do X without help" (a build, an answer, a decision), not "I
   know X".
2. Time per week, and the format of sessions (live 1:1? async?
   30 min? an hour?).
3. Level in this subject, and level in related subjects (the
   expertise-reversal diagnosis: what is a novice domain, what is an
   experienced domain — teaching style differs).
4. What they have done already (projects, courses, years of practice).
5. What they enjoy and what they avoid (where the plan has to pull,
   not push).
6. Where the work lives (this repo? their project repos?) and how the
   agent will reach it.
7. What "done" means to them: a certificate, a portfolio piece, a job
   they can take, a system they can run.

Ask at most 4 questions per turn, in plain language. Do not read the
answers back and ask them to confirm; just build.

## Write the files

### README.md
- One paragraph: what this is, for whom, what it gets them.
- The entry commands (below), verbatim.
- The loop in 6 lines: placement test → each lesson (exam, learn,
  explore, practice, check) → final interview.
- The honest line: "The agent prepares the exercises, tests the
  material, and asks the questions. You do the thinking. That is the
  point."

### AGENTS.md
Copy the protocol below. It is the classroom loop. Adjust the paths
and the domain vocabulary; do not change the structure. The CLASSROOM
PROTOCOL text is in `classroom.md` §A — include it verbatim.

### ROADMAP.md (per subject)
- Target (observable behavior, from the interview).
- Modules: name + the knowledge points it covers (a list, one line
  each).
- Lessons: one line each — `lNN. name — knowledge points`.
- Projects (optional): the learner's real projects, and which lesson
  should use them as the exercise base.
- Beginner domains: mark them, and restate the beginner rules
  (from the CLASSROOM PROTOCOL, section "Beginner domains") at the
  top of the roadmap so the mentor applying the roadmap sees them.
- Sizing: a module is 3-6 lessons. A lesson fits one sitting
  (30-90 min depending on the interview). If a module is bigger,
  split it.
- Order: dependencies first; a beginner domain first, even if the
  learner is more advanced elsewhere — the program's spine is built
  on the weakest ground, where it is most needed.
- End: the final interview, with the target restated.

### placement-test.md
- 2-3 questions per module, in the lesson's question format.
- Each question states what it is testing, in one line.
- A scoring table: a score per module (0-3), the rule for reading it
  (0-1: teach from the start of the module; 2: teach the module,
  skip the placement questions it already answers; 3: teach only
  the module's last lessons and the interview), and the rule for
  feeding results into `WEAK-POINTS.md` (a point missed on a question
  for a lesson not yet taught becomes a placement weak point for
  that lesson).
- Written from the learner's interview answers, so the questions
  test what they claim to know.

### interview-questions.md
- 3-5 per module, interview-style (open, no answer given).
- One "design / decide" question per module where judgment is the
  point.
- Mark the target level the interview is at.
- A scoring guide: what a strong answer contains, per module.

### classroom/ scaffolding
- `PROGRESS.md`: the two tables (lessons, weak points) from the
  CLASSROOM PROTOCOL, plus a "Current position" line.
- `WEAK-POINTS.md`: the table from the CLASSROOM PROTOCOL, empty.
- `NN/notes/.gitkeep`, `NN/exercises/.gitkeep`.
- Copy `subjects/_templates/` into place.

### First lesson
Write the first lesson file (module 1, lesson 1) now, per the
CLASSROOM PROTOCOL's lesson-writing rules. A program the learner can
start on is worth more than a roadmap.

## Entry commands (in README.md)

```
1. Say "Placement test for <subject>" — or just "Placement test" if
   the hub holds one subject.
2. Say "Start lesson mX-lYY".
3. Say "Check mX-lYY" when you finish the exercise.
4. Say "Interview me" at the end of the subject.
```

## Quality bar

- Every lesson file is written by the same hand that will teach it.
- Every number, command and output in a lesson file was actually run
  (or checked) before the lesson is offered.
- Every linked URL is one you verified exists.
- The placement test and the interview are harder than the lessons.
  They set the target.
- The hub is a repo. `git init`, first commit, hand the learner the
  entry commands.

## Adding a subject to an existing hub

Same interview, then: new `NN-slug/` folder, new ROADMAP, placement
test, interview bank, `classroom/NN/` scaffold, lesson 1. Update
README's subject list. Do not renumber existing subjects.
