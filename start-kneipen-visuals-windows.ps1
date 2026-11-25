[CmdletBinding()]
param(
    [switch]$NoWait,
    [string]$Preset = ''
)

$ErrorActionPreference = 'Stop'
$Root = Join-Path $env:LOCALAPPDATA 'Kneipen-Visuals\projectMSDL-2.0.0-win64'
$Executable = Join-Path $Root 'projectMSDL.exe'
$PresetDir = Join-Path $Root 'presets\Kneipen-Visuals'
$TextureDir = Join-Path $Root 'textures'

foreach ($Path in @($Executable, $PresetDir, $TextureDir)) {
    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Missing installation path: $Path. Run setup-windows.ps1 first."
    }
}

if ($Preset) {
    if ($Preset -notmatch '^[A-Za-z0-9_-]+(?:\.milk)?$') {
        throw 'Invalid preset name.'
    }
    $Name = [IO.Path]::GetFileNameWithoutExtension($Preset) + '.milk'
    $Source = Join-Path $PresetDir $Name
    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "Preset not installed: $Source. Run setup-windows.ps1 first."
    }
    $PresetDir = Join-Path (Join-Path $Root 'single-presets') ([IO.Path]::GetFileNameWithoutExtension($Name))
    New-Item -ItemType Directory -Force -Path $PresetDir | Out-Null
    Copy-Item -LiteralPath $Source -Destination (Join-Path $PresetDir $Name) -Force
}

$StartArgs = @{
    FilePath = $Executable
    WorkingDirectory = $Root
    ArgumentList = ('--presetPath "{0}" --texturePath "{1}"' -f $PresetDir, $TextureDir)
}
if ($NoWait) {
    Start-Process @StartArgs
} else {
    Start-Process @StartArgs -Wait
}
