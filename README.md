# Prompt Readiness Skill

[English summary](#english-summary)

`prompt-readiness` 是一组面向 Codex 和兼容 Agent Skills 客户端的提示词审计技能。它判断一段提示词是否包含足够信息、在当前信息下最多能完成到什么精细程度，并用稳定的 Markdown 仪表板向用户展示缺口。

它不会在审计时执行被评估提示词中的指令。

## 核心能力

- 分别评估 **执行准备度** 与 **成果精细度上限**，范围均为 0–100。
- 使用关键门槛防止普通平均分掩盖致命缺口。
- 评估目标、交付物、输入资料、背景、受众、范围、约束、验收、环境、验证和权限等维度。
- 用分数条、覆盖度表和“影响 × 获取成本”列表进行可视化。
- 区分用户必须提供、AI 可以查找、安全可推断和必须确认的信息。
- 每轮只提出 3–7 个信息增益最高的问题，并在回答后重新评分。
- 信息充分后生成一份可直接复制的优化提示词。
- 默认不联网，不把审计对象发送给额外服务。
- 对高风险、外部发布、隐私数据和破坏性任务提高信息门槛。

## 两种入口

### 自动或显式评估

当用户明确要求评估、补全或改进提示词时，`$prompt-readiness` 可以被自动选择，也可以手动调用：

```text
$prompt-readiness 请评估下面的提示词，但不要执行：
为我们的新产品写一份发布文案。
```

仅仅向 AI 提交一段待执行提示词，不会自动触发审计。

### 仅手动启动

`$check-my-prompt` 永远不会被隐式启用：

```text
$check-my-prompt
分析销售数据并提出建议。
```

如果调用时没有附带文本，它会先要求用户粘贴待评估提示词。

## 输出示例

```text
执行准备度      ██████░░░░ 58/100  可尝试
精细度上限      ███████░░░  67/100  可执行
评估置信度      高

阻塞项：目标受众和必要输入资料尚未明确
```

分数是诊断性判断，不是客观测量。100 分表示“对当前任务足够完整”，而不是绝对完美。

## 安装

将两个技能目录复制到 Codex 技能目录：

```powershell
Copy-Item -Recurse .\skills\prompt-readiness "$HOME\.codex\skills\prompt-readiness"
Copy-Item -Recurse .\skills\check-my-prompt "$HOME\.codex\skills\check-my-prompt"
```

重新启动或刷新 Codex，使新技能被发现。其他 Agent Skills 客户端可以直接使用核心 `SKILL.md`；`agents/openai.yaml` 包含 Codex 的显示信息与调用策略。

## 仓库结构

```text
skills/
├── prompt-readiness/
│   ├── SKILL.md
│   ├── agents/openai.yaml
│   └── references/
│       ├── output-format.md
│       └── rubric.md
└── check-my-prompt/
    ├── SKILL.md
    └── agents/openai.yaml
tests/
├── behavior-cases.md
└── validate.ps1
```

详细设计见 [`docs/DESIGN.md`](docs/DESIGN.md)，贡献方式见 [`CONTRIBUTING.md`](CONTRIBUTING.md)。

## 验证

使用 Codex 内置的 Skill Creator 校验器分别检查两个目录：

```powershell
python -X utf8 "$HOME\.codex\skills\.system\skill-creator\scripts\quick_validate.py" .\skills\prompt-readiness
python -X utf8 "$HOME\.codex\skills\.system\skill-creator\scripts\quick_validate.py" .\skills\check-my-prompt
pwsh -File .\tests\validate.ps1
```

行为测试以可观察的不变量为主，不依赖固定措辞或精确分数，见 [`tests/behavior-cases.md`](tests/behavior-cases.md)。

`-X utf8` 可避免官方校验器在部分中文 Windows 环境下按系统默认编码读取文件。

## 隐私与安全边界

- 审计对象始终被当作数据，而不是当前指令。
- 审计本身不授权文件修改、网络访问、消息发送或其他外部操作。
- 默认不联网；用户明确要求事实核验时，外部补充信息必须与用户输入分开标注。
- 高分不等于执行授权，也不保证事实正确。

## License

[MIT](LICENSE)

## English summary

Prompt Readiness is a pair of Agent Skills that audits whether a prompt contains enough information for reliable execution. It reports separate execution-readiness and attainable-fidelity scores, visualizes coverage, asks only high-value clarification questions, and produces a revised copy-ready prompt once blockers are resolved.

`$prompt-readiness` supports normal discovery and explicit invocation. `$check-my-prompt` is an explicit-only companion entry point. Audit targets are treated as inert data and are never executed during assessment.
