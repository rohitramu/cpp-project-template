$ErrorActionPreference = 'Stop'

$buildSystemDir = $Env:BUILD_SYSTEM_DIR

if ([string]::IsNullOrWhitespace($buildSystemDir)) {
    Write-Error 'Environment variable BUILD_SYSTEM_DIR is not set.  Please run init.ps1 before executing build.ps1.'
}

log "Starting build..." -Color Green

# log 'Formatting source files'
# Get-ChildItem -Path $Env:SRC_DIR -Include '*.cpp', '*.cc', '*.h', '*.hpp' -Recurse | ForEach-Object {
#     Write-Host "[FORMAT] $($_.Fullname)"
#     & 'clang-format' @(
#         '-i', # In-place format (i.e. format file, don't output to console)
#         '-style=file', # Get style rules from ".clang-format" file in root
#         '-fallback-style=none', # Fail if the ".clang-format" file doesn't exist
#         $_.FullName # File path
#     )
# }

log 'Configuring and generating build system'
& cmake -S . -B "$buildSystemDir" -G Ninja
if (-Not $?) {
    Write-Error "Failed to configure or generate build system.  Error code: $LASTEXITCODE."
}

log 'Building project'
& ninja -C "$buildSystemDir"
if (-Not $?) {
    Write-Error "Failed to build project.  Error code: $LASTEXITCODE."
}

log "Finished build" -Color Green