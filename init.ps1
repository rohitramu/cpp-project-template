#TODO: Convert all scripts to *.cmake files (and use cmake cache variables instead of
# environment variables).  This will allow IDEs to be opened directly instead of through an
# initialized PowerShell command line.

param(
    [Parameter(Position = 0)]
    [string] $BuildConfiguration = 'Debug'
)

$ErrorActionPreference = 'Stop'

#############
# Constants #
#############

#USER-TODO: Update the project name
$ProjectName = 'hello'

##############
# Validation #
##############

if ([string]::IsNullOrWhiteSpace($BuildConfiguration)) {
    Write-Error 'The "BuildConfiguration" parameter cannot be null or empty.'
}


#############################
# Set environment variables #
#############################

# Project name
$Env:PROJECT_NAME = $ProjectName
Write-Host "[ENV] PROJECT_NAME = `"$Env:PROJECT_NAME`""

# Project root
$Env:PROJECT_ROOT = $PSScriptRoot
Write-Host "[ENV] PROJECT_ROOT = `"$Env:PROJECT_ROOT`""

# Scripts directory
$Env:SCRIPTS_DIR = Join-Path -Path $Env:PROJECT_ROOT -ChildPath 'scripts'
Write-Host "[ENV] SCRIPTS_DIR = `"$Env:SCRIPTS_DIR`""

# Source directory
$Env:SRC_DIR = Join-Path -Path $Env:PROJECT_ROOT -ChildPath 'src'
Write-Host "[ENV] SRC_DIR = `"$Env:SRC_DIR`""

# Build type
$Env:BUILD_CONFIGURATION = $BuildConfiguration
Write-Host "[ENV] BUILD_CONFIGURATION = `"$Env:BUILD_CONFIGURATION`""

# Generated build system output
$Env:BUILD_SYSTEM_DIR = Join-Path -Path $Env:PROJECT_ROOT -ChildPath '.build_system'
$Env:BUILD_SYSTEM_DIR = Join-Path -Path $Env:BUILD_SYSTEM_DIR -ChildPath $Env:BUILD_CONFIGURATION
Write-Host "[ENV] BUILD_SYSTEM_DIR = `"$Env:BUILD_SYSTEM_DIR`""

# Build output
$Env:BUILD_OUTPUT_DIR = Join-Path -Path $Env:PROJECT_ROOT -ChildPath '.build_output'
$Env:BUILD_OUTPUT_DIR = Join-Path -Path $Env:BUILD_OUTPUT_DIR -ChildPath $Env:BUILD_CONFIGURATION
Write-Host "[ENV] BUILD_OUTPUT_DIR = `"$Env:BUILD_OUTPUT_DIR`""
$Env:BUILD_OUTPUT_BIN_DIR = Join-Path -Path $Env:BUILD_OUTPUT_DIR -ChildPath 'bin'
Write-Host "[ENV] BUILD_OUTPUT_BIN_DIR = `"$Env:BUILD_OUTPUT_BIN_DIR`""
$Env:BUILD_OUTPUT_LIB_DIR = Join-Path -Path $Env:BUILD_OUTPUT_DIR -ChildPath 'lib'
Write-Host "[ENV] BUILD_OUTPUT_LIB_DIR = `"$Env:BUILD_OUTPUT_LIB_DIR`""


######################
# Set script aliases #
######################

# Get the paths to all *.ps1 scripts in the scripts directory
$scripts = Get-ChildItem -Path $Env:SCRIPTS_DIR -Include '*.ps1' -Recurse

# Add this init script to the list
$initScript = Get-Item -Path $PSCommandPath
$scripts += $initScript

# Create aliases for each script, using the filenames as aliases
$scripts | ForEach-Object {
    $scriptName = $_.BaseName
    $scriptPath = $_.FullName

    Write-Host "[ALIAS] $scriptName = $scriptPath"
    Set-Alias -Scope global -Name $scriptName -Value $scriptPath
}
