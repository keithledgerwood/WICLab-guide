# Remove all shortcuts
#must be run as admin
Remove-Item C:\Users\*\Desktop\*lnk -Force
Remove-Item C:\Users\*\Desktop\Microsoft -Recurse
Remove-Item C:\Users\*\Desktop\logs -Recurse

##### Desktop Shortcuts
#Add Chrome Shortcut, blank
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Launch Chrome.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Save()

#Add Chrome Shortcut to Okta Lab Guide
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Launch Lab Guide.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "http://labs.demo.okta.com"
$shortcut.Save()

#Add Chrome Shortcut and launch as O365
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Launch Office 365.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "https://admin.microsoft.com"
$shortcut.Save()

#Add Chrome Shortcut to Flowpack
$shell = New-Object -comObject WScript.Shell
$shortcut = $shell.CreateShortcut("$Home\Desktop\Download Flowpack.lnk")
$shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcut.Arguments = "https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/workflows/titleChanged.flow"
$shortcut.Save()

#Shortcut for Notepad on Desktop
 $shell = New-Object -comObject WScript.Shell 
 $shortcut = $shell.CreateShortcut("$Home\Desktop\Notepad.lnk") 
 $shortcut.TargetPath = "%windir%\system32\notepad.exe" 
 $shortcut.Save()
 
#Add download shortcut to desktop
 $shell = New-Object -comObject WScript.Shell 
 $shortcut = $shell.CreateShortcut("$Home\Desktop\Downloads.lnk") 
 $shortcut.TargetPath = "C:\Users\Administrator\Downloads" 
 $shortcut.Save()

#Remove pinned icons from taskbar
Remove-Item -Path "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" -Force -Recurse 
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" -Force -Recurse 
Stop-Process -ProcessName explorer -Force
Start-process -WindowStyle hidden explorer 

#Replace Chrome Preferences file
iwr -uri https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/labvm/Preferences -OutFile .\Preferences  
copy-item .\Preferences -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force 

#Replace Chrome Bookmarks file
iwr -uri https://raw.githubusercontent.com/keithledgerwood/WICLab-guide/dev/labvm/Bookmarks -OutFile .\Bookmarks  
copy-item .\Bookmarks -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force 

#Downlaod Okta Verify and place in downloads folder
iwr -uri https://okta.okta.com/api/v1/artifacts/WINDOWS_OKTA_VERIFY/download?releaseChannel=GA -OutFile .\Downloads\OktaVerifySetup.exe  

$a = (New-Object -comObject Shell.Application).Windows() |
 ? { $_.FullName -ne $null} |
 ? { $_.FullName.toLower().Endswith('\explorer.exe') }
 $a | % { $_.Quit() }

exit





