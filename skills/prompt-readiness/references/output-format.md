# Output Format

Use the smallest format that communicates the diagnosis. Follow the user's language and adapt labels naturally.

## Initial audit

```markdown
## Prompt readiness

Execution readiness  `████████░░ 82/100`  Ready
Fidelity ceiling     `███████░░░ 74/100`  Executable
Assessment confidence: High

| Dimension | Coverage | Evidence or gap |
|---|---|---|
| Goal | Complete | ... |
| Inputs | Partial | ... |
| Audience | Missing | ... |

Blockers: None

### Highest-value missing information

| Priority | Information needed | Impact | Effort | Why it matters |
|---:|---|---|---|---|
| 1 | ... | High | Low | ... |

### Questions required to proceed

1. ...

Recommended default: ...

### Optional precision questions

- ...
```

Use ten blocks in each bar. Round the filled-block count from the score; always print the numeric score because the bar is intentionally approximate.

Coverage labels should be textual, optionally prefixed with stable symbols:

- `● Complete`
- `◐ Partial`
- `○ Missing`
- `! Conflicting`
- `— N/A`

Keep the table to applicable dimensions with meaningful evidence. Collapse uncomplicated complete dimensions into one row if a full table would add noise.

Omit empty sections. If no blocker exists, say `None` in one line. Do not imply that colorful rendering, an image, or an interactive chart is required.

## Follow-up audit

After answers, show score movement before repeating diagnosis:

```markdown
Execution readiness  58 → 84 (+26)
Fidelity ceiling     61 → 78 (+17)
```

Explain only changes caused by new information. Do not repeat settled questions.

## Assumption handoff

When the user chooses to continue without answering, list:

1. the assumption;
2. why it is needed;
3. its risk or effect on fidelity;
4. how the user can override it.

Never disguise an unknown fact as an assumption when correctness, permission, safety, cost, privacy, or external impact depends on it.

## Revised prompt

After required questions are resolved or assumptions are authorized, return a fenced block titled `Revised prompt` that is ready to copy. Structure it only as much as the task needs. A complex prompt may include:

- Goal
- Context and supplied inputs
- Deliverable
- Scope and constraints
- Audience and format
- Quality or acceptance criteria
- Verification
- Authorized assumptions or unresolved placeholders

Do not include the audit commentary inside the revised prompt. Keep unresolved values explicit using descriptive placeholders such as `[TARGET AUDIENCE NEEDED]`.
