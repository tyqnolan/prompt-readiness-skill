# Contributing / 贡献指南

Contributions should improve observable audit behavior without turning isolated examples into universal rules.

提交修改时，请遵循以下原则：

1. 保持 `check-my-prompt` 为轻量手动入口；评分逻辑只存在于 `prompt-readiness`。
2. 新增规则前，先在 `tests/behavior-cases.md` 添加一个能体现真实失败方式的案例。
3. 测试应验证行为不变量，不要依赖固定措辞、标题或精确分数。
4. 修改 `agents/openai.yaml` 时，保持两个入口的调用策略不变，除非该变化是明确目标。
5. 不要让审计评分暗示事实正确、操作安全或已获得执行授权。

提交前运行：

```powershell
python -X utf8 "$HOME\.codex\skills\.system\skill-creator\scripts\quick_validate.py" .\skills\prompt-readiness
python -X utf8 "$HOME\.codex\skills\.system\skill-creator\scripts\quick_validate.py" .\skills\check-my-prompt
pwsh -File .\tests\validate.ps1
```

For behavioral changes, document which test case motivated the change and verify that prompt content remains inert during assessment.
