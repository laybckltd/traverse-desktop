$ErrorActionPreference = "Stop"

$AppName = 'Traverse'
$AppUrl = 'https://wonderful-creponne-588f15.netlify.app'

$Candidates = @(
  "$env:ProgramFiles(x86)\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "$env:ProgramFiles(x86)\Google\Chrome\Application\chrome.exe",
  "$env:LocalAppData\Google\Chrome\Application\chrome.exe"
)

$BrowserExe = $Candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $BrowserExe) {
  Write-Host "Edge or Chrome not found in standard paths. Creating web shortcut (.url) instead..."
  $DesktopUrl = Join-Path ([Environment]::GetFolderPath('Desktop')) "$AppName.url"
  @("[InternetShortcut]", "URL=$AppUrl") | Set-Content -Path $DesktopUrl -Encoding ASCII
  Write-Host "Created shortcut: $DesktopUrl"
  exit 0
}

$WshShell = New-Object -ComObject WScript.Shell
$Targets = @(
  [Environment]::GetFolderPath('Desktop'),
  "$env:AppData\Microsoft\Windows\Start Menu\Programs"
)

foreach ($Dir in $Targets) {
  if (Test-Path $Dir) {
    $LnkPath = Join-Path $Dir "$AppName.lnk"
    $Shortcut = $WshShell.CreateShortcut($LnkPath)
    $Shortcut.TargetPath = $BrowserExe
    $Shortcut.Arguments = "--app=""$AppUrl"" --new-window"
    $Shortcut.Description = "$AppName Desktop Web Application"
    $Shortcut.IconLocation = "$BrowserExe,0"
    $Shortcut.Save()
    Write-Host "Installed shortcut: $LnkPath"
  }
}

Write-Host "$AppName is ready on your Desktop and Start Menu."
