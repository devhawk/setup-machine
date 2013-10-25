@echo off

echo Updating PowerShell execution Policy
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile Set-ExecutionPolicy RemoteSigned -Force

IF NOT EXIST %SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe  GOTO SkipWow64
echo Updating WOW64 PowerShell execution Policy
%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe -noprofile Set-ExecutionPolicy RemoteSigned -Force

:SkipWow64

SET DIR=%~dp0%

echo Setting up console defaults
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -ExecutionPolicy unrestricted -Command "& '%DIR%setup-console-defaults.ps1' %*"

echo Removing start menu .lnk file console defaults
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe -noprofile -ExecutionPolicy unrestricted -Command "& '%DIR%remove-console-props.ps1' %*"

echo Setting up Chocolatey
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy unrestricted -Command "& '%DIR%install-chocolatey.ps1' %*"

echo Setting common Chocolatey packages
%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy unrestricted -Command "& '%DIR%install-choco-packages.ps1' %*"