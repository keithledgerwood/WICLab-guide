# Remove all shortcuts
#must be run as admin
Remove-Item C:\Users\*\Desktop\*lnk -Force
Remove-Item C:\Users\*\Desktop\Microsoft -Recurse
Remove-Item C:\Users\*\Desktop\logs -Recurse

#Add Chrome Shortcut and launch as O365
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Launch Office 365.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "https://admin.microsoft.com"
$shortcut.Save()

#Shortcut to Flowpack
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Download Flowpack.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/workflows/titleChanged.flow"
$shortcut.Save()


#Add Chrome Shortcut to Okta Demo
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Launch Lab Guide.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "http://labs.demo.okta.com"
$shortcut.Save()

#Add download folder to desktop
#New-Item "$Home\Desktop\Download" -ItemType Directory

#Remove pinned icons from taskbar
Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force -Recurse 
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force -Recurse 
Stop-Process -ProcessName explorer -Force
Start-Process explorer 

#Replace Chrome Preferences file
iwr -uri https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/labvm/Preferences -OutFile .\Preferences  
copy-item .\Preferences -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force 

#Replace Chrome Bookmarks file
iwr -uri https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/labvm/Bookmarks -OutFile .\Bookmarks  
copy-item .\Bookmarks -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force 






