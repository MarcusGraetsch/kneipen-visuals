[CmdletBinding()]
param(
    [string]$LogoPath = '',
    [string]$InstallRoot = (Join-Path $env:LOCALAPPDATA 'Kneipen-Visuals\projectMSDL-2.0.0-win64')
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ReleaseVersion = '2.0.0-pre1'
$ArchiveName = 'projectMSDL-2.0.0-win64.zip'
$DownloadUrl = "https://github.com/projectM-visualizer/frontend-sdl-cpp/releases/download/$ReleaseVersion/$ArchiveName"
$ExpectedSha256 = '7129cae0757970bd4fb2bf96aa7d6153fe9872d414c88c82b04a6396bdfe235b'
$ArchivePath = Join-Path $env:TEMP $ArchiveName
$StageRoot = Join-Path $env:TEMP "kneipen-visuals-$ReleaseVersion"
$AppDataRoot = Join-Path $env:APPDATA 'projectM'
$CustomPresetRoot = Join-Path $InstallRoot 'presets\Kneipen-Visuals'
$ConfigPath = Join-Path $AppDataRoot 'projectMSDL.properties'

function Fail([string]$Message) {
    Write-Error "FEHLER: $Message"
    exit 1
}

if (-not [Environment]::Is64BitOperatingSystem) {
    Fail 'Dieses Windows-Release unterstützt nur 64-Bit-Windows.'
}

if (-not (Test-Path -LiteralPath $RepoRoot)) {
    Fail "Repository-Verzeichnis nicht gefunden: $RepoRoot"
}

if (-not $LogoPath) { $LogoPath = Join-Path $RepoRoot 'textures\pirata_logo.png' }
if (-not (Test-Path -LiteralPath $LogoPath -PathType Leaf) -or [IO.Path]::GetExtension($LogoPath) -ne '.png') {
    Fail "PNG-Logo fehlt: $LogoPath"
}
$LogoBytes = [IO.File]::ReadAllBytes($LogoPath)
if ($LogoBytes.Length -lt 8 -or [BitConverter]::ToString($LogoBytes,0,8) -ne '89-50-4E-47-0D-0A-1A-0A') {
    Fail "Ungültiges PNG: $LogoPath"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$Executable = Join-Path $InstallRoot 'projectMSDL.exe'
if (-not (Test-Path -LiteralPath $Executable)) {
    Write-Host "Lade natives projectMSDL für Windows herunter..."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ArchivePath -UseBasicParsing

    $ActualSha256 = (Get-FileHash -LiteralPath $ArchivePath -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($ActualSha256 -ne $ExpectedSha256) {
        Remove-Item -LiteralPath $ArchivePath -Force -ErrorAction SilentlyContinue
        Fail "SHA-256-Prüfung fehlgeschlagen. Erwartet: $ExpectedSha256, erhalten: $ActualSha256"
    }

    if (Test-Path -LiteralPath $StageRoot) {
        Remove-Item -LiteralPath $StageRoot -Recurse -Force
    }
    New-Item -ItemType Directory -Path $StageRoot | Out-Null
    Expand-Archive -LiteralPath $ArchivePath -DestinationPath $StageRoot -Force

    $ExtractedExecutable = Get-ChildItem -LiteralPath $StageRoot -Filter 'projectMSDL.exe' -File -Recurse | Select-Object -First 1
    if ($null -eq $ExtractedExecutable) {
        Fail 'Das Windows-Archiv enthält keine projectMSDL.exe.'
    }

    $ExtractedRoot = $ExtractedExecutable.Directory.FullName
    New-Item -ItemType Directory -Path (Split-Path -Parent $InstallRoot) -Force | Out-Null
    if (Test-Path -LiteralPath $InstallRoot) {
        Remove-Item -LiteralPath $InstallRoot -Recurse -Force
    }
    Move-Item -LiteralPath $ExtractedRoot -Destination $InstallRoot
    Remove-Item -LiteralPath $StageRoot -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $ArchivePath -Force -ErrorAction SilentlyContinue
}

New-Item -ItemType Directory -Path $CustomPresetRoot -Force | Out-Null
Get-ChildItem -LiteralPath (Join-Path $RepoRoot 'presets') -Filter '*.milk' -File | Copy-Item -Destination $CustomPresetRoot -Force

$TextureRoot = Join-Path $InstallRoot 'textures'
New-Item -ItemType Directory -Path $TextureRoot -Force | Out-Null
Copy-Item -LiteralPath $LogoPath -Destination (Join-Path $TextureRoot 'pirata_logo.png') -Force
foreach ($OldLogo in @('pirata_logo.jpg','pirata_logo.jpeg')) {
    Remove-Item -LiteralPath (Join-Path $TextureRoot $OldLogo) -ErrorAction SilentlyContinue
}
New-Item -ItemType Directory -Path $AppDataRoot -Force | Out-Null
if (Test-Path -LiteralPath $ConfigPath) {
    Copy-Item -LiteralPath $ConfigPath -Destination "$ConfigPath.bak" -Force
}
$PresetPath = ($CustomPresetRoot -replace '\\', '/')
$Config = @"
# Kneipen-Visuals configuration. The projectM window can be moved to the projector.
window.fullscreen = false
window.monitor = 0
window.width = 1280
window.height = 720
projectM.presetPath = `${application.dir}/presets
projectM.presetPath.1 = $PresetPath
projectM.texturePath = `${application.dir}/textures
projectM.enableSplash = false
projectM.displayDuration = 25
projectM.shuffleEnabled = true
projectM.presetLocked = false
projectM.fps = 60
projectM.meshX = 48
projectM.meshY = 36
projectM.transitionDuration = 5
projectM.hardCutsEnabled = true
projectM.hardCutDuration = 20
projectM.aspectCorrectionEnabled = true
"@
[IO.File]::WriteAllText($ConfigPath, $Config, (New-Object System.Text.UTF8Encoding($false)))

Write-Host ''
Write-Host 'FERTIG! Native Windows-Installation wurde eingerichtet.' -ForegroundColor Green
Write-Host "Programm: $Executable"
Write-Host "Konfiguration: $ConfigPath"
Write-Host 'Start: .\start-kneipen-visuals-windows.cmd'
