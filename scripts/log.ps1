param(
    [Parameter(Mandatory, Position = 0)]
    [string]$Message,

    [Parameter(Position = 1)]
    [ConsoleColor]$Color = [ConsoleColor]::Yellow
)

# Write-Progress -Activity 'build.ps1' -PercentComplete -1 -Status $Message
Write-Host $Message -ForegroundColor $Color