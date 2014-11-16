#------------------------------------------------------------------------------
# Locate top level OneDrive path

if (test-path ~\OneDrive) {
  $local:oneDrivePath = resolve-path ~\OneDrive
} elseif (test-path ~\SkyDrive) {
  $local:oneDrivePath = resolve-path ~\SkyDrive
} else {
  Write-Warning "Cannot Locate OneDrive Path"
}

#------------------------------------------------------------------------------
# add OneDrive\Scripts folder to path for access to scripts

if ($local:oneDrivePath -ne $null) {
  set-content env:path "$env:path;$(join-path $local:oneDrivePath 'Scripts')"
}

#------------------------------------------------------------------------------
#set the screen color based on the user role

if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  $host.UI.RawUI.Backgroundcolor="DarkRed"
  $host.UI.RawUI.WindowTitle = "PowerShell Admin Console"
} else {
  $host.UI.RawUI.Backgroundcolor="Black"
  $host.UI.RawUI.WindowTitle = "PowerShell User Console"
}

$host.UI.RawUI.Foregroundcolor="White"

if ($env:PROCESSOR_ARCHITECTURE -eq "x86") {
  $host.UI.RawUI.WindowTitle += " (x86)"
} else {
  $host.UI.RawUI.WindowTitle += " (x64)"
}

clear-host

#------------------------------------------------------------------------------
# override built in prompt function w/ prompt.ps1

function global:prompt {
  $locStackCount = (Get-Location -stack).count  
  Write-Host $executionContext.SessionState.Path.CurrentLocation.ProviderPath -foregroundcolor Cyan
  if ($locStackCount -gt 0) {
    write-host ("+" * $locStackCount) -NoNewLine -ForegroundColor Yellow
    write-host " " -NoNewLine 
  }
  write-host "PS»" -NoNewLine -ForegroundColor Green
  return " "
}

#------------------------------------------------------------------------------
#set some common aliases
set-alias su elevate-process.ps1
set-alias vs devenv
set-alias fp find-in-path.ps1

# Look for locally installed versions of git & n2
#set-alias n2 (join-path $local:oneDrivePath "Utilities\Notepad2.exe")
#set-alias git (join-path $local:oneDrivePath "Utilities\Git\cmd\git.exe")
#set-alias gitk (join-path $local:oneDrivePath "Utilities\Git\cmd\gitk.cmd")
