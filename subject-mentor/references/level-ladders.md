# Level ladders — diagnose, then teach at the level

## Generic ladder (any domain)

| Level | What it looks like |
|---|---|
| Novice | Needs worked examples and direct instruction. Cannot predict outcomes. |
| Intermediate | Handles the common cases unaided; stuck on the unusual ones. |
| Advanced | Handles the unusual cases; can explain why. |
| Expert | Designs the approach, sets the standard, teaches it. |

Diagnose per domain, then teach at that level (expertise reversal
effect). A person can be at Run in one area and Crawl in another.
Track per area.

## Engineering variant (mid → senior → staff)

| Dimension | Mid | Senior | Staff |
|---|---|---|---|
| Scope | Features within a system | A system end to end, incl. production | Multiple systems / org direction |
| Technical depth | Uses tools well | Knows why they work; debugs below the abstraction | Shapes the tools / platform |
| Design | Implements designs | Makes and documents trade-offs; ADRs | Sets architecture direction |
| Production | Ships | Owns reliability, observability, incidents | Designs for org-wide reliability |
| Ambiguity | Needs clear tasks | Turns vague problems into plans | Finds the problems worth solving |
| Influence | Owns work | Reviews, mentors, raises team quality | Multiplies many teams |
| Communication | Status updates | Design docs, explains trade-offs to non-engineers | Writes strategy |

## Skills AI does not replace (and that make you better *with* AI)

1. Problem framing and requirements: deciding what to build.
2. Trade-off judgment and architecture, documented (ADRs).
3. Debugging and code reading — the skill most damaged by AI
   over-reliance, and most needed to check AI output.
4. Production ownership: observability, performance, reliability,
   security, incident response.
5. Data and systems depth: databases, concurrency, networking,
   memory.
6. Domain knowledge of the business.
7. Communication, mentoring, influence.

## Portfolio / profile review checklist

- Can a recruiter or crawler see the site? (SSR/SSG, meta tags,
  OpenGraph)
- Is the headline current (role, stack, focus)?
- 4-6 pinned repos with a README: problem, architecture diagram,
  decisions + trade-offs, how it is tested, what you would do next.
- Evidence of production thinking: tests, CI, monitoring,
  deployment.
- Separate learning repos (courses, forks) from products.
- One written artifact showing judgment (blog post, ADR, postmortem).
- Honest labelling of AI-assisted vs. self-written work.

## Evidence vs. claims

When reviewing, prefer evidence (commits, tests, READMEs, decisions)
over claims (skill badges). Note what is AI-generated or
tutorial-derived; it shows exposure, not mastery.
