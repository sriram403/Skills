# Installs the skills library for every agent on this machine. Safe to run again.
#  1. Links each skills\<name> into ~\.claude\skills (Claude Code) and ~\.agents\skills (Codex)
#     as a directory junction, so edits in the library are live everywhere.
#  2. Writes global\GLOBAL_INSTRUCTIONS.md between markers in ~\.claude\CLAUDE.md and
#     ~\.codex\AGENTS.md, leaving the rest of each file alone.
# A real folder already in the way is moved to ~\.claude\skills-backup\<timestamp>\ first, never deleted.

$ErrorActionPreference = 'Stop'
$root      = Split-Path -Parent $PSScriptRoot
$skillsDir = Join-Path $root 'skills'
$globalMd  = Join-Path $root 'global\GLOBAL_INSTRUCTIONS.md'
$stamp     = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupDir = Join-Path $HOME ".claude\skills-backup\$stamp"

$targets = @(
    (Join-Path $HOME '.claude\skills'),
    (Join-Path $HOME '.agents\skills')
)
$instructionFiles = @(
    (Join-Path $HOME '.claude\CLAUDE.md'),
    (Join-Path $HOME '.codex\AGENTS.md')
)

$skills = Get-ChildItem -Path $skillsDir -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

foreach ($target in $targets) {
    if (-not (Test-Path $target)) { New-Item -ItemType Directory -Path $target | Out-Null }

    foreach ($skill in $skills) {
        $link = Join-Path $target $skill.Name
        $item = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
        if ($item) {
            if ($item.LinkType) {
                if ($item.Target -contains $skill.FullName) { continue }   # already right
                [IO.Directory]::Delete($link)                            # stale link: remove the link only
            } else {
                New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
                $dest = Join-Path $backupDir ((Split-Path $target -Parent | Split-Path -Leaf) + '-' + $skill.Name)
                Move-Item -LiteralPath $link -Destination $dest
                Write-Host "backed up $link -> $dest"
            }
        }
        New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
        Write-Host "linked $link -> $($skill.FullName)"
    }

    # Remove links that point into the library at a skill that no longer exists.
    Get-ChildItem -LiteralPath $target -Force | Where-Object { $_.LinkType } | ForEach-Object {
        $t = @($_.Target)[0]
        if ($t -and $t.StartsWith($skillsDir, [StringComparison]::OrdinalIgnoreCase) -and -not (Test-Path $t)) {
            [IO.Directory]::Delete($_.FullName)
            Write-Host "removed stale link $($_.FullName)"
        }
    }
}

$start = "<!-- skills-library:start (managed by $root\scripts\install.ps1; edit global\GLOBAL_INSTRUCTIONS.md there instead) -->"
$end   = '<!-- skills-library:end -->'
$body  = ([IO.File]::ReadAllText($globalMd)).Trim().Replace('{{SKILLS_ROOT}}', $root)
$block = "$start`n$body`n$end"
$utf8  = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $instructionFiles) {
    $dir = Split-Path -Parent $file
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $text = if (Test-Path $file) { [IO.File]::ReadAllText($file) } else { '' }
    $pattern = '(?s)<!-- skills-library:start.*?<!-- skills-library:end -->'
    if ($text -match $pattern) {
        $new = [regex]::Replace($text, $pattern, { param($m) $block })
    } else {
        $new = $text.TrimEnd() + $(if ($text.Trim()) { "`n`n" } else { '' }) + $block + "`n"
    }
    $new = $new -replace "`r`n", "`n"
    if ($new -ne ($text -replace "`r`n", "`n")) {
        [IO.File]::WriteAllText($file, $new, $utf8)
        Write-Host "updated $file"
    } else {
        Write-Host "unchanged $file"
    }
}

Write-Host "done: $($skills.Count) skills linked for Claude Code and Codex"
