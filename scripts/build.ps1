$ErrorActionPreference = 'Stop'

$buildSystemDir = $Env:BUILD_SYSTEM_DIR

if ([string]::IsNullOrWhitespace($buildSystemDir)) {
    Write-Error 'Environment variable BUILD_SYSTEM_DIR is not set.  Please run init.ps1 before executing build.ps1.'
}

Write-Host "Starting build..." -ForegroundColor Green

Write-Host 'Configuring and generating build system' -ForegroundColor Yellow
& cmake -S . -B "$buildSystemDir" -G Ninja
if (-Not $?) {
    Write-Error "Failed to configure or generate build system.  Error code: $LASTEXITCODE."
}

Write-Host 'Building project' -ForegroundColor Yellow
& ninja -C "$buildSystemDir"
if (-Not $?) {
    Write-Error "Failed to build project.  Error code: $LASTEXITCODE."
}

Write-host "Finished build" -ForegroundColor Green