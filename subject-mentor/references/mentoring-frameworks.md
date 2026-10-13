# Mentoring frameworks

Adapted from the "Senior Engineering Mentor" skill (rikdc) and the "Mentoring Developers" skill (melodic-software), combined with learning science.

## Crawl → Walk → Run

| Stage | Learner does | Mentor does | Evidence of readiness to move on |
|---|---|---|---|
| Crawl | Studies worked examples, copies with changes, explains each line | Shows, explains in plain words, one new thing at a time | Can explain the example without looking |
| Walk | Completes partial solutions; builds with a test harness | Writes tests/scaffold; fades hints; reviews | Passes tests without asking; can predict failures |
| Run | Builds from blank; makes design decisions; teaches it | Asks questions, critiques decisions, raises the bar | Builds + explains + defends trade-offs |

A learner can be at Run in one area and Crawl in another. Track per area.

## Socratic questioning — when and how

Use for judgment areas where the learner has a base (design, trade-offs, career, debugging in a known stack). Do **not** use as a hint ladder for a true novice in a new language — give worked examples instead.

Question bank:
- Clarify: "What problem are we actually solving? For whom?"
- Assumptions: "What are you assuming about load / data / users?"
- Evidence: "How would you know it works? What would you measure?"
- Alternatives: "What else did you consider? Why not that?"
- Consequences: "What fails first? What's the blast radius? What does it cost in 2 years?"
- Meta: "What would change your mind?"

## Senior review framework

1. Context: business goal, scale, constraints.
2. What's good (specific).
3. Concerns — each with issue, impact, options (pros/cons), recommendation.
4. Questions to explore.
5. Time horizons: 0–6 months, 6–18 months, 18+.
6. Decision points the *learner* must decide.

Lenses: scalability, reliability/failure modes, maintainability, performance, security, observability ("how do we debug this at 3 a.m.?"), organizational impact.

## Feedback structure

Acknowledge (specific) → one or two improvements → why it matters → what to try next. Humble tone ("in my experience"), not prescriptive, but honest about real problems.

## Career 1:1 template

```
Date:
1. Retrieval warm-up (from review list)        — confidence → result
2. Since last time: done / blocked / surprised
3. Topic of the day
4. Practice / decision / explanation by learner
5. Feedback
6. Exit ticket
7. Next action (one), next review dates
```

Monthly: progress vs. goals, level-ladder check, adjust plan. Quarterly: re-evaluate goals and market.

## Psychological safety

Mistakes are data. Ask "what made that seem right?" not "why did you do that?". Separate the person from the code. Celebrate good questions and good "I don't know"s. Keep commitments small enough to succeed.
