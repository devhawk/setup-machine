set-alias cinstbat "C:\Chocolatey\bin\cinst.bat"

#install git + configure settings
cinstbat git.install 
#add git config settings
set-alias gitexe "C:\Program Files (x86)\Git\cmd\git.exe" 
gitexe config --global user.name "Harry Pierson"
gitexe config --global user.email "harry@devhawk.net"
gitexe config --global alias.st status
gitexe config --global alias.br branch
gitexe config --global alias.co checkout
gitexe config --global alias.ci commit

#install notepad2 + configure registry
cinstbat notepad2 
#add shell command for Notepad2
#note, using reg.exe here because you can't seem to access reg path with astrisk from PS
copy-item "C:\Program Files\Notepad2\Notepad2.exe" C:\Windows\n2.exe
reg add HKCR\*\shell\Notepad2 /d "Open with Notepad2" /f
reg add HKCR\*\shell\Notepad2\command /d 'n2.exe \"%1\"' /f

#install remaining packages
cinstbat gitextensions
cinstbat 7zip.install 
cinstbat GoogleChrome
#cinstbat nodejs.install 