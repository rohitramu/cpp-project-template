$ErrorActionPreference = 'Stop'

$buildSystemDir = $Env:BUILD_SYSTEM_DIR

if ([string]::IsNullOrWhitespace($buildSystemDir)) {
    Write-Error 'Environment variable BUILD_SYSTEM_DIR is not set.  Please run init.ps1 before executing build.ps1.'
}

log "Starting build..." -Color Green

log 'Formatting source files'
Get-ChildItem -Path $Env:SRC_DIR -Include '*.cpp', '*.cc', '*.h' -Recurse | ForEach-Object {
    Write-Host "Test: $($_.Fullname)"
    & 'clang-format' @(
        '-i',
        '-style=file'
        $_.FullName
    )
}

log 'Configuring build system'
& cmake -S . -B "$buildSystemDir" -G Ninja
if (-Not $?) {
    Write-Error "Failed to configure build system.  Error code: $LASTEXITCODE."
}

log 'Generating build system'
& cmake "$buildSystemDir"
if (-Not $?) {
    Write-Error "Failed to generate build system.  Error code: $LASTEXITCODE."
}

log 'Building project'
& ninja -C "$buildSystemDir"
if (-Not $?) {
    Write-Error "Failed to build project.  Error code: $LASTEXITCODE."
}

log "Finished build" -Color Green