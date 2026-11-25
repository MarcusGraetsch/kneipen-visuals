[CmdletBinding()]
param(
    [switch]$NoWait,
    [string]$Preset = ''
)

$ErrorActionPreference = 'Stop'
$Executable = Join-Path $env:LOCALAPPDATA 'Kneipen-Visuals\projectMSDL-2.0.0-win64\projectMSDL.exe'

if (-not (Test-Path -LiteralPath $Executable)) {
    Write-Error 'projectMSDL ist nicht installiert. Bitte zuerst .\setup-windows.ps1 ausführen.'
    exit 1
}

$Root = Split-Path -Parent $Executable
$PresetDir = Join-Path $Root 'presets\Kneipen-Visuals'
$TextureDir = Join-Path $Root 'textures'
if ($Preset) {
    if ($Preset -notmatch '^[A-Za-z0-9_-]+(?:\.milk)?
    FilePath = $Executable
    ArgumentList = ('--presetPath "{0}" --texturePath "{1}"' -f $PresetDir, $TextureDir)
    WorkingDirectory = Split-Path -Parent $Executable
}
if ($NoWait) {
    Start-Process @StartArgs
} else {
    Start-Process @StartArgs -Wait
}
) { throw 'Ungültiger Presetname' }
    $Name = [IO.Path]::GetFileNameWithoutExtension($Preset) + '.milk'
    $Source = Join-Path $PresetDir $Name
    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) { throw "Preset nicht installiert: $Source" }
    $PresetDir = Join-Path $Root ('single-presets\' + [IO.Path]::GetFileNameWithoutExtension($Name))
    New-Item -ItemType Directory -Force $PresetDir | Out-Null
    Copy-Item -LiteralPath $Source -Destination (Join-Path $PresetDir $Name) -Force
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
