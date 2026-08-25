# Prompt Readiness Rubric

Use this rubric whenever the skill assigns scores. It supports calibrated judgment; it is not a deterministic formula.

## Coverage dimensions

Start with these baseline weights and adapt them to the task. Explain material changes. Redistribute the weight of genuinely inapplicable dimensions across the applicable dimensions; never award points merely because a dimension is `N/A`.

| Dimension | Baseline | Look for |
|---|---:|---|
| Goal | 15 | Desired outcome, decision, or state change |
| Deliverable | 12 | Artifact or answer to produce, including quantity |
| Inputs and evidence | 12 | Source material, data, examples, and dependencies |
| Context | 8 | Background and why the task matters |
| Audience | 7 | Intended reader or user and their knowledge level |
| Scope | 8 | Included and excluded work, boundaries, and priorities |
| Constraints | 8 | Time, budget, policy, style, technology, and non-negotiables |
| Output format | 5 | Structure, medium, schema, length, or destination |
| Quality and acceptance | 10 | What success means and how it will be judged |
| Tools and environment | 5 | Available systems, files, versions, and operating context |
| Verification | 5 | Tests, sources, review method, or evidence required |
| Risk, authority, and permissions | 5 | Authorization, privacy, reversibility, and external effects |

For each applicable dimension, assign a coverage state:

- `Complete` — actionable and internally consistent.
- `Partial` — usable only with limited assumptions.
- `Missing` — needed information is absent.
- `Conflicting` — supplied information cannot all be followed.
- `N/A` — the dimension genuinely does not affect this task.

Conflicting information is a blocker when different resolutions would materially change execution.

## Execution readiness

Estimate weighted coverage, then apply the most restrictive relevant cap:

- Cap at **39** when there is no actionable goal, the audit target cannot be identified, or the request is internally incoherent.
- Cap at **59** when a required deliverable, essential input, must-confirm choice, necessary permission, or safety-critical fact is missing.
- Cap at **79** when the task is executable but success criteria or material boundaries remain ambiguous enough to cause substantial rework.

Do not apply a cap for a low-risk default that is easy to state, reverse, and correct.

Use these readiness bands:

| Score | Band | Operational meaning |
|---:|---|---|
| 0–39 | Blocked | Cannot begin reliably |
| 40–59 | Attemptable | Requires major assumptions |
| 60–79 | Executable | Can proceed, but material precision is limited |
| 80–89 | Ready | Sufficient for high-quality execution; only minor gaps remain |
| 90–100 | Highly specified | Inputs, boundaries, and acceptance conditions are unusually clear |

A score of 100 means sufficient for this task, not universally perfect.

## Fidelity ceiling

Judge the maximum plausible output quality under the current information. Give extra attention to:

- the specificity and quality of source inputs;
- audience and contextual fit;
- examples, voice, and desired level of detail;
- acceptance criteria and verification;
- task-domain uncertainty that cannot be removed by competent execution.

Fidelity may be lower than readiness: an agent may be able to produce a generic draft while lacking the information needed for a precise, production-ready result. It may occasionally be slightly higher when the requested task is simple and robust to missing preferences. Explain gaps of 15 points or more between the two scores.

## Assessment confidence

- `High` — the target and intended task are clear, and the rubric fits the domain well.
- `Medium` — some task interpretation or domain calibration is uncertain, but the main gaps are identifiable.
- `Low` — the target is ambiguous, context is fragmentary, or specialized domain knowledge is required to judge sufficiency.

Confidence must not inflate or reduce either score. It qualifies how much trust to place in the assessment.

## High-risk calibration

For high-risk work, missing authority, current facts, jurisdiction, affected systems or people, rollback plans, or verification can be blockers even when an ordinary task could infer defaults. Never interpret an audit score as authorization to execute.
