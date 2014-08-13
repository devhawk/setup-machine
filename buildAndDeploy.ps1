write-output "Building setup-machine.bat"
.\build.ps1

if (test-path ~\OneDrive) {
  $local:oneDrivePath = resolve-path ~\OneDrive
} elseif (test-path ~\SkyDrive) {
  $local:oneDrivePath = resolve-path ~\SkyDrive
} else {
  Write-Error "Cannot Locate OneDrive Path"
}

write-output "Copying setup-machine.bat to local OneDrive folder"
copy-item .\setup-machine.bat (join-path $local:oneDrivePath "Scripts")