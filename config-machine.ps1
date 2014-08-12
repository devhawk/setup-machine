#------------------------------------------------------------------------------
# Locate top level OneDrive path

if (test-path ~\onedrive) {
  $local:oneDrivePath = resolve-path ~\OneDrive
} elseif (test-path ~\skydrive) {
  $local:oneDrivePath = resolve-path ~\SkyDrive
} else {
  Write-Warning "Cannot Locate OneDrive Path"
}

# Copy profile from OneDrive to correct location in my documents
$local:profileDestPath = split-path $profile
if (!(test-path $local:profileDestPath)) {
  mkdir $local:profileDestPath | Out-Null
}
$local:profileSource = join-path $local:oneDrivePath "Scripts\Microsoft.PowerShell_profile.ps1"
Copy-Item $local:profileSource $PROFILE

# Configure shell to include Open with Notepad2 context menu item
$local:n2path = join-path $local:oneDrivePath "Utilities\Notepad2.exe"
if (test-path $local:n2path) {
  reg add HKCR\*\shell\Notepad2 /d "Open with Notepad2" /f
  reg add HKCR\*\shell\Notepad2\command /d "$local:n2path `"`"%1`"`"" /f
}

# Configure git global settings 
$local:gitpath = join-path $local:oneDrivePath "Utilities\Git\cmd\git.exe"
if (test-path $local:gitpath) {
  & $local:gitpath config --global user.name "Harry Pierson"
  & $local:gitpath config --global user.email "harry@devhawk.net"
  & $local:gitpath config --global alias.st status
  & $local:gitpath config --global alias.br branch
  & $local:gitpath config --global alias.co checkout
  & $local:gitpath config --global alias.ci commit
}

