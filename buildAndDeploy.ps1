write-output "Building setup-machine.bat"
.\build.ps1

#todo: Update script to copy setup-machine to remote skydrive folder
write-output "Copying setup-machine.bat to local skydrive folder"
copy-item .\setup-machine.bat "C:\Users\hpierson\SkyDrive\Scripts"