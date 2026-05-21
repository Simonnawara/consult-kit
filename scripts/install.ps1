# install.ps1 — installs consult-kit into the current repository
# Usage:
#   .\install.ps1            first install
#   .\install.ps1 -Update    update an existing install (preserves outputs/)

param(
    [switch]$Update
)

# ── Configuration ─────────────────────────────────────────────────────────────
$RepoUrl = "https://github.com/YOUR_USERNAME/consult-kit"
$Branch  = "main"
# ─────────────────────────────────────────────────────────────────────────────

$ErrorActionPreference = "Stop"

function Write-Step  ($msg) { Write-Host "`n$msg" -ForegroundColor White }
function Write-Ok    ($msg) { Write-Host "  $msg" -ForegroundColor Green }
function Write-Warn  ($msg) { Write-Host "  $msg" -ForegroundColor Yellow }
function Write-Fail  ($msg) { Write-Host "  $msg" -ForegroundColor Red }

# ── Preflight ─────────────────────────────────────────────────────────────────
Write-Step "Checking dependencies..."

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Fail "Error: git is required but not installed."
    exit 1
}

if ($RepoUrl -like "*YOUR_USERNAME*") {
    Write-Fail "Error: RepoUrl has not been configured."
    Write-Warn "Edit the `$RepoUrl variable at the top of this script before running."
    exit 1
}

# ── Download ──────────────────────────────────────────────────────────────────
Write-Step "Downloading consult-kit from GitHub..."

$TempDir = Join-Path $env:TEMP ("consult-kit-" + [System.IO.Path]::GetRandomFileName())

try {
    git clone --depth 1 --branch $Branch $RepoUrl $TempDir --quiet
    Write-Ok "Downloaded successfully."
} catch {
    Write-Fail "Failed to clone repository: $_"
    exit 1
}

# ── Install kit files ─────────────────────────────────────────────────────────
Write-Step "Installing kit files..."

# These are always overwritten — they are the tool itself
Copy-Item -Path "$TempDir\.consult-kit" -Destination "." -Recurse -Force
Write-Ok ".consult-kit/ → updated"

Copy-Item -Path "$TempDir\.github" -Destination "." -Recurse -Force
Write-Ok ".github/ → updated"

Copy-Item -Path "$TempDir\providers" -Destination "." -Recurse -Force
Write-Ok "providers/ → updated"

# README only on first install
if (-not (Test-Path "README.md") -or -not $Update) {
    if (Test-Path "$TempDir\README.md") {
        Copy-Item -Path "$TempDir\README.md" -Destination "." -Force
        Write-Ok "README.md → installed"
    }
}

# ── Output directories ────────────────────────────────────────────────────────
Write-Step "Setting up output directories..."

New-Item -ItemType Directory -Force -Path "outputs\audit"   | Out-Null
New-Item -ItemType Directory -Force -Path "outputs\estimate" | Out-Null

if (-not (Test-Path "outputs\audit\.gitkeep")) {
    New-Item -ItemType File -Path "outputs\audit\.gitkeep" | Out-Null
    Write-Ok "outputs/audit/ → created"
} else {
    Write-Ok "outputs/audit/ → already exists, skipped"
}

if (-not (Test-Path "outputs\estimate\.gitkeep")) {
    New-Item -ItemType File -Path "outputs\estimate\.gitkeep" | Out-Null
    Write-Ok "outputs/estimate/ → created"
} else {
    Write-Ok "outputs/estimate/ → already exists, skipped"
}

# ── .gitignore ────────────────────────────────────────────────────────────────
Write-Step "Checking .gitignore..."

$GitignoreBlock = @"

# consult-kit outputs
outputs/audit/*
outputs/estimate/*
!outputs/audit/.gitkeep
!outputs/estimate/.gitkeep
"@

if (-not (Test-Path ".gitignore")) {
    Copy-Item -Path "$TempDir\.gitignore" -Destination "." -Force
    Write-Ok ".gitignore → created"
} elseif (-not (Select-String -Path ".gitignore" -Pattern "consult-kit outputs" -Quiet)) {
    Add-Content -Path ".gitignore" -Value $GitignoreBlock
    Write-Ok ".gitignore → consult-kit rules appended"
} else {
    Write-Ok ".gitignore → already contains consult-kit rules, skipped"
}

# ── Cleanup ───────────────────────────────────────────────────────────────────
Remove-Item -Recurse -Force $TempDir

# ── Done ──────────────────────────────────────────────────────────────────────
Write-Host ""
Write-Host "✅ consult-kit installed successfully." -ForegroundColor Green
Write-Host ""
Write-Host "  Copilot:     @engagement-orchestrator"
Write-Host "  Claude Code: /engagement"
Write-Host ""
Write-Host "  Describe the client project and brief to get started."