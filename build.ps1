function encode($scriptName) {
 $command = get-content -raw $scriptName
 $bytes = [System.Text.Encoding]::Unicode.GetBytes($command)
 return [Convert]::ToBase64String($bytes)
}

$psexe = "%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe"
$pswowexe = "%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe"

$scripts = @('setup-console-defaults.ps1', 'remove-console-props.ps1', 'config-machine.ps1')
$preamble = @"
@echo off

echo DevHawk Setup-Machine
REM source for this script available at http://github.com/devhawk/setup-machine

echo Updating PowerShell execution Policy
$psexe -noprofile Set-ExecutionPolicy RemoteSigned -Force

IF NOT EXIST $pswowexe GOTO SkipWow64
echo Updating WOW64 PowerShell execution Policy
$pswowexe -noprofile Set-ExecutionPolicy RemoteSigned -Force

:SkipWow64
"@

#$datestr =  (get-date).TOstring('yyyy-MM-ddTHH-mm-ss')
#$filename = "setup-machine.$datestr.bat"
$filename = "setup-machine.bat"

set-content $filename $preamble

$scripts | foreach {
  $encoded = encode $_
  add-content $filename "echo running $_"
  add-content $filename "$psexe -noprofile -ExecutionPolicy unrestricted -EncodedCommand $encoded"
}