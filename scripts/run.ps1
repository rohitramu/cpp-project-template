param(
    [Parameter(ValueFromRemainingArguments, Position=0)]
    [string[]]
    $args = $null
)

$ErrorActionPreference = 'Stop'

$binDir = $Env:BUILD_OUTPUT_BIN_DIR
$projectName = $Env:PROJECT_NAME

if ([string]::IsNullOrWhitespace($binDir)) {
    Write-Error 'Environment variable BUILD_OUTPUT_BIN_DIR is not set.  Please run init.ps1 before executing run.ps1.'
}

if ([string]::IsNullOrWhitespace($projectName)) {
    Write-Error 'Environment variable PROJECT_NAME is not set.  Please run init.ps1 before executing run.ps1.'
}

$exePath = Join-Path -Path $binDir -ChildPath $projectName

& $exePath $args