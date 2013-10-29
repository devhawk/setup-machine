cinst git.install 
cinst gitextensions
cinst 7zip.install 
cinst nodejs.install 
cinst notepad2 

#add shell command for Notepad2
copy-item "C:\Program Files\Notepad2\Notepad2.exe" C:\Windows\n2.exe
reg add HKCR\*\shell\Notepad2 /d "Open with Notepad2"
reg add HKCR\*\shell\Notepad2\command /d 'n2.exe \"%1\"'

#add git config settings
git config --global user.name "Harry Pierson"
git config --global user.email "harry@devhawk.net"
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.ci commit