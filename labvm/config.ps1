$labName=$labName.replace('demo-','')
echo "Running as Lab Name: $labName"

 #Type needed for MoveWindow & Screen Size
 Add-Type '
 using System;
 using System.Runtime.InteropServices;

 public class Win32 {
     [DllImport("user32.dll")]
     [return: MarshalAs(UnmanagedType.Bool)]
     public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
 }
' -PassThru

Add-Type -AssemblyName System.Windows.Forms

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
$shortcut.Arguments = "https://demo-$labName.okta.com"
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
iwr -uri https://cdn.demo.okta.com/labs/techcamps_wic/labvm/Preferences -OutFile .\Preferences  
copy-item .\Preferences -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force 

#Replace Chrome Bookmarks file
iwr -uri https://cdn.demo.okta.com/labs/techcamps_wic/labvm/Bookmarks -OutFile .\Bookmarks  
if ($labName){
    (Get-Content .\Bookmarks).Replace('https://labs.demo.okta.com/', "https://labs.demo.okta.com/lab/$labName") | Set-Content .\Bookmarks
    (Get-Content .\Bookmarks).Replace('https://demo-lab-name.okta.com', "https://demo-$labName.okta.com") | Set-Content .\Bookmarks
}

copy-item .\Bookmarks -Destination "C:\Users\Administrator\AppData\Local\Google\Chrome\User Data\Default" -recurse -Force  

$a = (New-Object -comObject Shell.Application).Windows() |
 ? { $_.FullName -ne $null} |
 ? { $_.FullName.toLower().Endswith('\explorer.exe') }
 $a | % { $_.Quit() }

#Open Google Chrome into Appropriate Position - Disabled for now 11/10/2023
#$screen=[System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
#$googleapp = Start-Process 'C:\Program Files\Google\Chrome\Application\chrome.exe' -ArgumentList "https://demo-$($labName).okta.com --window-size=$($screen.Width-600),$($screen.Height) --window-position=150,0 " -PassThru

#Download Okta Verify and place in downloads folder
iwr -uri https://okta.okta.com/api/v1/artifacts/WINDOWS_OKTA_VERIFY/download?releaseChannel=GA -OutFile C:\Users\Administrator\Downloads\OktaVerifySetup.exe 

 # Check the current version of the .NET Framework
 $dotNetVersion = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Version
 Write-Output "Current .NET Framework version: $dotNetVersion"  
 if ($dotNetVersion -lt 4.8) {    
     #Download .NET 4.8 Offline Installer    
     iwr -uri https://go.microsoft.com/fwlink/?linkid=2088631 -OutFile C:\Users\Administrator\Downloads\NET4.8Installer.exe    
     C:\Users\Administrator\Downloads\NET4.8Installer.exe /q
} 

#Call Workflow Event Hook Callback to report completion!
iwr -uri "https://wiclabs.workflows.okta.com/api/flo/56e61c09c9f8daea0eb589944e8a0da2/invoke?clientToken=ced202ef1b57d8790a4cd13910e9835073254b6ddb9f65c636b9e339b4b18569&hostname=$env:computername&labid=$labName&type=vm.powershell.run&status=SUCCESS"

exit