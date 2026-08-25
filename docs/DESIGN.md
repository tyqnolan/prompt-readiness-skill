# Design Notes / 设计说明

## Product boundary

The skill evaluates task-specification completeness. It does not claim that supplied facts are true, that the requested action is safe, or that the user has authorized execution. Fact verification is a separate, opt-in activity.

技能衡量的是任务规格是否充分，不保证输入事实正确，也不把评估视为执行授权。事实核验是独立且需要用户明确要求的活动。

## Architecture

The package contains two skills:

1. `prompt-readiness` owns all audit behavior and can be selected when the user explicitly asks for prompt evaluation.
2. `check-my-prompt` is an explicit-only wrapper that delegates to the core skill.

The wrapper intentionally contains no scoring logic, which prevents the two entry points from drifting apart.

## Decision model

The audit separates three questions:

- Can an agent execute this task reliably now?
- How precise can the result become with only the current information?
- How confident is the auditor in those judgments?

Execution readiness uses weighted coverage plus blocker caps. Fidelity ceiling emphasizes source quality, audience fit, examples, acceptance criteria, and irreducible uncertainty. Assessment confidence qualifies the audit without changing either score.

## Interaction model

Missing information is classified by who can resolve it. The skill only asks the user for private or subjective inputs and decisions that materially affect the outcome. Public facts and inspectable environment state remain the agent's responsibility when the user later authorizes discovery.

Questions are ranked by information gain. Required questioning stops at readiness 80 with no blockers, or immediately when the user chooses to proceed under stated assumptions.

## Visualization model

The baseline output uses Markdown because it is portable, inspectable, and available without tools. Score bars provide a quick visual signal; numeric scores, readiness bands, evidence, and gap tables preserve meaning when formatting is limited.

## Security model

The text under audit is untrusted content. Embedded instructions cannot change the audit workflow or cause execution. This prevents prompt-injection-like content from escaping the analysis boundary.

## Compatibility

Core behavior is expressed in standard `SKILL.md` files. Codex-specific interface metadata and implicit-invocation policy live under `agents/openai.yaml` so other compatible Agent Skills clients can reuse the instructions.
