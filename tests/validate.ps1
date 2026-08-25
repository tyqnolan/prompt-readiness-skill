[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repositoryRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path

function Require-File {
    param([Parameter(Mandatory)][string]$RelativePath)

    $candidate = Join-Path $repositoryRoot $RelativePath
    if (-not (Test-Path -LiteralPath $candidate -PathType Leaf)) {
        throw "Required file is missing: $RelativePath"
    }
    return $candidate
}

$mainSkillPath = Require-File 'skills/prompt-readiness/SKILL.md'
$mainAgentPath = Require-File 'skills/prompt-readiness/agents/openai.yaml'
$rubricPath = Require-File 'skills/prompt-readiness/references/rubric.md'
Require-File 'skills/prompt-readiness/references/output-format.md' | Out-Null
$manualSkillPath = Require-File 'skills/check-my-prompt/SKILL.md'
$manualAgentPath = Require-File 'skills/check-my-prompt/agents/openai.yaml'

$textFiles = Get-ChildItem -LiteralPath $repositoryRoot -Recurse -File |
    Where-Object { $_.Extension -in @('.md', '.yaml', '.yml', '.ps1') }
foreach ($file in $textFiles) {
    if ($file.FullName -eq $PSCommandPath) {
        continue
    }
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding utf8
    if ($content -match '\[TODO|TODO:|\[PLACEHOLDER') {
        throw "Unfinished scaffold marker found in $($file.FullName)"
    }
}

$mainSkill = Get-Content -LiteralPath $mainSkillPath -Raw -Encoding utf8
$manualSkill = Get-Content -LiteralPath $manualSkillPath -Raw -Encoding utf8
$mainAgent = Get-Content -LiteralPath $mainAgentPath -Raw -Encoding utf8
$manualAgent = Get-Content -LiteralPath $manualAgentPath -Raw -Encoding utf8

if ($mainSkill -notmatch '(?m)^name: prompt-readiness$') {
    throw 'Main skill frontmatter name is invalid.'
}
if ($manualSkill -notmatch '(?m)^name: check-my-prompt$') {
    throw 'Manual skill frontmatter name is invalid.'
}
if ($mainAgent -notmatch '(?m)^\s*allow_implicit_invocation: true$') {
    throw 'Main skill must permit implicit invocation.'
}
if ($manualAgent -notmatch '(?m)^\s*allow_implicit_invocation: false$') {
    throw 'Manual skill must be explicit-only.'
}
if ($manualSkill -notmatch '\$prompt-readiness') {
    throw 'Manual skill must delegate to the main skill.'
}

$rubric = Get-Content -LiteralPath $rubricPath -Encoding utf8
$weights = foreach ($line in $rubric) {
    if ($line -match '^\| [^|]+ \| (\d+) \|') {
        [int]$Matches[1]
    }
}
if (($weights | Measure-Object -Sum).Sum -ne 100) {
    throw 'Baseline rubric weights must sum to 100.'
}

Write-Output 'Package validation passed.'
