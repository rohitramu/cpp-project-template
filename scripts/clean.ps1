$ErrorActionPreference = 'Stop'

$buildOutputDir = $Env:BUILD_OUTPUT_DIR
$buildSystemDir = $Env:BUILD_SYSTEM_DIR

if ([string]::IsNullOrWhitespace($buildOutputDir)) {
    Write-Error 'Environment variable BUILD_OUTPUT_DIR is not set.  Please run init.ps1 before executing clean.ps1.'
}

if ([string]::IsNullOrWhitespace($buildSystemDir)) {
    Write-Error 'Environment variable BUILD_SYSTEM_DIR is not set.  Please run init.ps1 before executing clean.ps1.'
}

Remove-Item -Path $buildOutputDir -Recurse -Force -ErrorAction Ignore
Remove-Item -Path $buildSystemDir -Recurse -Force -ErrorAction Ignore