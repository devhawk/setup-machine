function encode($scriptName) {
 
 $command = get-content $scriptName
 $bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
 return [Convert]::ToBase64String($bytes)
}

$scripts = @('setup-console-defaults.ps1', 'remove-console-props.ps1', 'install-chocolatey.ps1', 'install-choco-packages.ps1')
$preamble = @"
@echo off

echo Updating PowerShell execution Policy
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile Set-ExecutionPolicy RemoteSigned -Force

IF NOT EXIST %SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe  GOTO SkipWow64
echo Updating WOW64 PowerShell execution Policy
%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe -noprofile Set-ExecutionPolicy RemoteSigned -Force

:SkipWow64
"@

$filename = "foo.bat"

set-content $filename $preamble

$scripts | foreach {
  $encoded = encode $_
  add-content $filename "echo running $_"
  add-content $filename "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -ExecutionPolicy unrestricted -EncodedCommand $encoded`n"
  
}