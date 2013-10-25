#Setup-Machine

##Overview

Working for the Windows team, I setup *lots* of Windows machines. In order to make this less of a hassle, I've got scripts to help setup a freshly paved machine. This is one of those scripts, intended to setup PowerShell and the console window the way I like it. I also use this to install [Chocolatey](http://chocolatey.org/) and a set of Chocolatey packages I always need.

There are four aspects to this script:

* Configuring PowerShell's execution policy 
* Configuring Windows' built-in Console app settings (font, window size, etc)
* Installing Chocolatey
* Install Chocolatey Packages I always use (git, node.js, notepad2, etc.)

For execution policy, I configure both the main PowerShell version as well as the WOW64 version to use [RemoteSigned execution policy](http://technet.microsoft.com/en-us/library/ee176961.aspx)

For console settings, I set the defaults in HKCU:\Console, remove any app-specific console settings under HKCU:\Console and iterate over the all the .lnk files in the start menu and remove their console data block via [IShellLinkDataList::RemoveDataBlock](http://msdn.microsoft.com/en-us/library/bb774918.aspx). Yes, I realize that there are other, better console replacements out there. But it's easier for me to setup the built-in console app the way I like it when I set the PowerShell execution policy rather than always install a new console app on every fresh install.

For Chocolatey, I'm just using the official [Install-Chocolatey](https://github.com/chocolatey/chocolatey/blob/master/chocolateyInstall/InstallChocolatey.ps1) script. I then have a separate script that is a series of [cinst](https://github.com/chocolatey/chocolatey/wiki/CommandsInstall) calls for the packages I always want installed on a fresh machine. 

In order to make this script portable and easily runnable on a fresh Windows install, I'm generating a batch file rather than a PowerShell script. It's easy to right-click on the setup-machine.bat file and select "Run as administrator" from the context menu. In order to make the script portable, I have a build script that takes the powershell scripts, encodes them as base64 and concatenates the scripts into a single bat file.

##To Build

Run build.ps1 from a PowerShell console window. The result is setup-machine.bat without external dependencies that you can run on both x86 and x64 Windows machines.

##To Use

Right click on setup-machine.bat and select "Run as administrator" from the context menu.
