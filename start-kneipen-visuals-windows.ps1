[CmdletBinding()]
param(
    [switch]$NoWait
)

$ErrorActionPreference = 'Stop'
$Executable = Join-Path $env:LOCALAPPDATA 'Kneipen-Visuals\projectMSDL-2.0.0-win64\projectMSDL.exe'

if (-not (Test-Path -LiteralPath $Executable)) {
    Write-Error 'projectMSDL ist nicht installiert. Bitte zuerst .\setup-windows.ps1 ausführen.'
    exit 1
}

$StartArgs = @{
    FilePath = $Executable
    WorkingDirectory = Split-Path -Parent $Executable
}
if ($NoWait) {
    Start-Process @StartArgs
} else {
    Start-Process @StartArgs -Wait
}
