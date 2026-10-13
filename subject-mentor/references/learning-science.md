# The science of learning — what to use and how

Sources: Brown, Roediger & McDaniel, *Make It Stick: The Science of Successful Learning* (2014); Dunlosky et al. (2013), "Improving Students' Learning With Effective Learning Techniques", *Psychological Science in the Public Interest* 14(1); Bjork & Bjork (2011), "desirable difficulties"; Sweller (cognitive load theory); Kalyuga et al. (2003), expertise reversal effect; Ericsson (deliberate practice); Chi (ICAP, self-explanation); Rawson & Dunlosky (successive relearning).

## Evidence ranking (Dunlosky et al. 2013)

| Technique | Utility | Use it as |
|---|---|---|
| Practice testing (retrieval) | High | Session warm-ups, exit tickets, quizzes, build-from-blank |
| Distributed practice (spacing) | High | Review schedule 1d → 3d → 1w → 2w → 1m |
| Interleaved practice | Moderate | Mix old + new problem types in the same session |
| Elaborative interrogation | Moderate | "Why is this true? Why here and not there?" |
| Self-explanation | Moderate | "Explain each line / each step in your own words" |
| Summarization, keyword mnemonics, imagery | Low | Only as extras |
| Highlighting, re-reading | Low | Avoid. They create an illusion of fluency |

## The techniques, applied to engineering

**1. Retrieval practice.** Recall from memory before looking. For code: write it from a blank file; predict output before running; explain an error message before reading the docs. Low stakes, frequent. Feedback right after.

**2. Spacing.** Stop a topic before it feels finished; come back later. Forgetting a bit then retrieving is what strengthens memory. Keep a review list with dates.

**3. Successive relearning.** Retrieve until correct once per session, across several spaced sessions. The best-supported combination of 1 + 2.

**4. Interleaving.** Mix problem types (ownership, error handling, traits) instead of blocks of one type. Harder in the moment, better at choosing the right tool later.

**5. Generation.** Try before being shown: sketch a design, guess an API, attempt the bug fix. Even wrong attempts improve what is learned from the answer.

**6. Elaboration.** Connect the new idea to what they know ("Rust `Result` vs throwing in TypeScript: what is different and why?"). Explain in own words; give own example.

**7. Reflection.** After a session or incident: What happened? What worked? What would I do differently? What does this connect to? Write it down (a learning log / `STAGE-LOG.md` / decision record).

**8. Calibration.** Rate confidence (1–5) before answering; compare with results. Track over time. Overconfidence → more retrieval. Underconfidence → show evidence of progress.

**9. Desirable difficulties.** Effort that feels slow but builds durable skill (retrieval, spacing, interleaving, generation). Distinguish from undesirable difficulty (confusing explanations, too many new things at once).

**10. Cognitive load.** Working memory is small. For novices in a domain: worked examples, one new element at a time, no split attention, plain words, no unnecessary analogies. Fade scaffolding as competence grows: worked example → completion problem (fill the gap) → full problem.

**11. Expertise reversal.** What helps novices (detailed guidance, worked examples) hurts experts (redundant load). Match guidance to the learner's level *in that specific domain*, and re-check as they improve.

**12. Deliberate practice.** Specific target just beyond current ability, full concentration, immediate feedback, repetition with refinement. Not "doing more projects" — doing the hard part on purpose.

**13. Growth mindset framing.** Struggle is the mechanism, not a sign of inability. Say this when progress feels slow.

**14. Teach-back (Feynman).** Explain to a beginner in plain words; gaps show where the explanation breaks. A blog post, README, or talk counts.

## Session recipe (≈ 60–90 min, for 2–4 h/week learners)

1. 5 min: retrieval warm-up on old material (confidence first).
2. 5 min: review of last session's log.
3. 10–15 min: one new concept — worked example if novice in domain.
4. 30–45 min: practice — completion problem or independent build.
5. 5 min: exit ticket — 2 recall questions + 3-sentence explanation.
6. 2 min: log it and schedule reviews.
